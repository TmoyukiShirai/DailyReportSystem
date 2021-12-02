package actions;

import java.io.IOException;
import java.util.List; //追記

import javax.servlet.ServletException;

import actions.views.EmployeeView; //追記
import actions.views.ReportView; //追記
import constants.AttributeConst;
import constants.ForwardConst;
import constants.JpaConst; //追記
import services.ReportService; //追記

/**
 * トップページに関する処理を行うActionクラス
 *
 */

public class TopAction extends ActionBase {

    private ReportService service; //追記、★フィールドの定義

    /**
     * indexメソッドを実行する
     */
    @Override
    public void process() throws ServletException, IOException {
            service = new ReportService(); //追記

            //メソッドを実行
            invoke();

            service.close(); //追記
        }


    public void index() throws ServletException, IOException {
        if (checkAdmin()) { //管理者の場合、全日報を表示

            //指定されたページ数の一覧画面に表示する日報データを取得
            int page = getPage();
            List<ReportView> reports = service.getAllPerPage(page);

            //全日報データの件数を取得
            long reportsCount = service.countAll();

            putRequestScope(AttributeConst.REPORTS, reports); //取得した日報データ
            putRequestScope(AttributeConst.REP_COUNT, reportsCount); //全ての日報データの件数
            putRequestScope(AttributeConst.PAGE, page); //ページ数
            putRequestScope(AttributeConst.MAX_ROW, JpaConst.ROW_PER_PAGE); //1ページに表示するレコードの数

            //セッションにフラッシュメッセージが設定されている場合はリクエストスコープに移し替え、セッションからは削除する
            String flush = getSessionScope(AttributeConst.FLUSH);
            if (flush != null) {
                putRequestScope(AttributeConst.FLUSH, flush);
                removeSessionScope(AttributeConst.FLUSH);
            }

            //一覧画面を表示
            forward(ForwardConst.FW_REP_INDEX);
        }else {
            //セッションからログイン中の従業員情報を取得
            EmployeeView loginEmployee = (EmployeeView) getSessionScope(AttributeConst.LOGIN_EMP);

            //ログイン中の従業員が作成した日報データを、指定されたページ数の一覧画面に表示する分取得する
            int page = getPage();
            List<ReportView> reports = service.getMinePerPage(loginEmployee, page);

            //ログイン中の従業員が作成した日報データの件数を取得
            long myReportsCount = service.countAllMine(loginEmployee);

            putRequestScope(AttributeConst.REPORTS, reports); //取得した日報データ
            putRequestScope(AttributeConst.REP_COUNT, myReportsCount); //ログイン中の従業員が作成した日報の数
            putRequestScope(AttributeConst.PAGE, page); //ページ数
            putRequestScope(AttributeConst.MAX_ROW, JpaConst.ROW_PER_PAGE); //1ページに表示するレコードの数

            //セッションにフラッシュメッセージが設定されている場合はリクエストスコープに移し替え、セッションからは削除する
            String flush = getSessionScope(AttributeConst.FLUSH);
            if (flush != null) {
                putRequestScope(AttributeConst.FLUSH, flush);
                removeSessionScope(AttributeConst.FLUSH);
            }

            //一覧画面を表示
            forward(ForwardConst.FW_TOP_INDEX);
        }
    }

    /* true: 管理者 false: 管理者ではない
     * @throws ServletException
     * @throws IOException
     */
    private boolean checkAdmin() throws ServletException, IOException {
        //セッションからログイン中の従業員情報を取得
        EmployeeView ev = (EmployeeView) getSessionScope(AttributeConst.LOGIN_EMP);
        if (ev.getAdminFlag() != AttributeConst.ROLE_ADMIN.getIntegerValue()) {

            return false; //管理者でなければfalseを返す

        } else {

            return true;
        }
    }
}

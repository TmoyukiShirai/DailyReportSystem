package actions;


import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;

import actions.views.ReportView;
import constants.AttributeConst;
import constants.ForwardConst;
import constants.JpaConst;
import services.ReportService;




public class SearchAction extends ActionBase {

    private ReportService service;

    /**
     * メソッドを実行する
     */
    @Override
    public void process() throws ServletException, IOException {

        service = new ReportService();

        //メソッドを実行
        invoke();

        service.close();
    }


    public void search() throws ServletException, IOException {
        //検索に該当する従業員情報を取得、検索したタイトルに該当する日報を取得
        String check = getRequestParam(AttributeConst.CHECK);
        String search = getRequestParam(AttributeConst.SEARCH);

        //検索に該当する従業員が作成した日報データを、指定されたページ数の一覧画面に表示する分取得する
        int page = getPage();
        // if 名前で検索された場合
        if (check.equals("name")) {
            List<ReportView> reports = service.getReportBySearchPerPage(search, page);
            //検索に該当する従業員が作成した日報データの件数を取得
            long myReportsCount = service.countAllBySearch(search);
            putRequestScope(AttributeConst.REPORTS, reports); //取得した日報データ
            putRequestScope(AttributeConst.REP_COUNT, myReportsCount); //検索した従業員が作成した日報の数
        }
        if (check.equals("title")){  // if タイトルで検索された場合
            //検索したタイトルに該当する日報データを、指定されたページ数の一覧画面に表示する分取得する
            List<ReportView> reports = service.getTitleBySearchPerPage(search, page);
            //検索したタイトルに該当する日報データの件数を取得
            long myReportsCount = service.countTitleBySearch(search);
            putRequestScope(AttributeConst.REPORTS, reports); //タイトルをキーに取得した日報データ
            putRequestScope(AttributeConst.REP_COUNT, myReportsCount); //検索した日報の数
        }
        if (check.equals("unapproved")){ // if 未承認のみ絞り込みたい場合
            List<ReportView> reports = service.getAllUnapprovedPerPage(page); //検索欄は空欄なので、引数にsearchは受け取らない。
            //未承認の日報データの件数を取得
            long myReportsCount = service.countAllUnapproved();
            putRequestScope(AttributeConst.REPORTS, reports); //取得した日報データ
            putRequestScope(AttributeConst.REP_COUNT, myReportsCount); //未承認の日報の数
        }


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
    }
}


//public void searchUnapproved() throws ServletException, IOException {
//
//}
//

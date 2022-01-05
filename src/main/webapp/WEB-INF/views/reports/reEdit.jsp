<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="constants.ForwardConst" %>
<%@ page import="constants.AttributeConst" %>

<c:set var="actTop" value="${ForwardConst.ACT_TOP.getValue()}" />
<c:set var="actRep" value="${ForwardConst.ACT_REP.getValue()}" />
<c:set var="commUpd" value="${ForwardConst.CMD_UPDATE.getValue()}" />
<c:set var="commResubmit" value="${ForwardConst.CMD_RESUBMIT.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">

        <h2>日報 再提出ページ</h2>
        <form method="POST" action="<c:url value='?action=${actRep}&command=${commResubmit}' />">
            <c:if test="${errors != null}">
               <div id="flush_error">
                入力内容にエラーがあります。<br />
               <c:forEach var="error" items="${errors}"><c:out value="${error}" /><br /></c:forEach>
               </div>
            </c:if>
            <fmt:parseDate value="${report.reportDate}" pattern="yyyy-MM-dd" var="reportDay" type="date" />
            <label for="${AttributeConst.REP_DATE.getValue()}">日付</label><br />
            <input type="date" name="${AttributeConst.REP_DATE.getValue()}" value="<fmt:formatDate value='${reportDay}' pattern='yyyy-MM-dd' />" />
            <br /><br />

            <label for="name">氏名</label><br />
            <c:out value="${sessionScope.login_employee.name}" />
            <br /><br />

            <label for="${AttributeConst.REP_TITLE.getValue()}">タイトル</label><br />
            <input type="text" name="${AttributeConst.REP_TITLE.getValue()}" value="${report.title}" />
            <br /><br />

            <label for="${AttributeConst.REP_CONTENT.getValue()}">内容</label><br />
            <textarea name="${AttributeConst.REP_CONTENT.getValue()}" rows="10" cols="50">${report.content}</textarea>
            <br /><br />
            <input type="hidden" name="${AttributeConst.REP_ID.getValue()}" value="${report.id}" />
            <input type="hidden" name="${AttributeConst.TOKEN.getValue()}" value="${_token}" />
            <input type="hidden" name="${AttributeConst.REP_APPROVAL.getValue()}" value="再提出済" />
            <button type="submit">再提出</button>
        </form>

        <p>
            <a href="<c:url value='?action=Top&command=index' />">一覧に戻る</a>
        </p>
    </c:param>
</c:import>
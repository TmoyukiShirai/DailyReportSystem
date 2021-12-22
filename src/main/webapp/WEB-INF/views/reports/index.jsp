<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="constants.ForwardConst" %>
<%@ page import="constants.AttributeConst" %>

<c:set var="actRep" value="${ForwardConst.ACT_REP.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commShow" value="${ForwardConst.CMD_SHOW.getValue()}" />
<c:set var="commShowAdmin" value="${ForwardConst.CMD_SHOW_ADMIN.getValue()}" />
<c:set var="commNew" value="${ForwardConst.CMD_NEW.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
        </c:if>
        <h2>
            <span class="allreports">日報　一覧</span>
            <span class="wrap">
             　　<form action="" autocomplete="on">
                <input id="search" name="search" type="text" placeholder="氏名、タイトルで検索"><input id="search-submit" value="Rechercher" type="submit">
                </form>
            </span>
        </h2>
        <table id="report_list">
            <tbody>
                <tr>
                    <th class="report_name">氏名</th>
                    <th class="report_date">日付</th>
                    <th class="report_title">タイトル</th>
                    <th class="report_approval">承認</th>
                    <th class="report_comment">コメント</th>
                    <th class="report_action">操作</th>

                </tr>
                <c:forEach var="report" items="${reports}" varStatus="status">
                    <fmt:parseDate value="${report.reportDate}" pattern="yyyy-MM-dd" var="reportDay" type="date" />

                    <tr class="row${status.count % 2}">
                        <td class="report_name"><c:out value="${report.employee.name}" /></td>
                        <td class="report_date"><fmt:formatDate value='${reportDay}' pattern='yyyy-MM-dd' /></td>
                        <td class="report_title">${report.title}</td>
                        <td class="report_approval">

                           <c:if test="${report.approval == null}">
                               <span class="char-blue">
                               <c:out value="未承認"/>
                               </span>
                           </c:if>

                        　　<span <c:if test="${report.approval == '再提出'}">class="char-red"</c:if>>
                            <c:out value="${report.approval}"/>
                           </span>

                            <span <c:if test="${report.approval != 'OK' or null}">${report.approval}</c:if>>
                            </span>
                        </td>
                         <td class="report_comment"><c:out value="${report.comment}" /></td>
                         <td class="report_action">
                            <c:if test="${sessionScope.login_employee.adminFlag == AttributeConst.ROLE_ADMIN.getIntegerValue()}">
                                <a href="<c:url value='?action=${actRep}&command=${commShowAdmin}&id=${report.id}' />">詳細を見る</a>
                            </c:if>
                            <c:if test="${sessionScope.login_employee.adminFlag != AttributeConst.ROLE_ADMIN.getIntegerValue()}">
                                <a href="<c:url value='?action=${actRep}&command=${commShow}&id=${report.id}' />">詳細を見る</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            （全 ${reports_count} 件）<br />
            <c:forEach var="i" begin="1" end="${((reports_count - 1) / maxRow) + 1}" step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='?action=${actRep}&command=${commIdx}&page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <p><a href="<c:url value='?action=${actRep}&command=${commNew}' />">新規日報の登録</a></p>

    </c:param>
</c:import>


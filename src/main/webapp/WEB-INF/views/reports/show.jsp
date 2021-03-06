

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="constants.ForwardConst" %>

<c:set var="actTop" value="${ForwardConst.ACT_TOP.getValue()}" />
<c:set var="actRep" value="${ForwardConst.ACT_REP.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commEdt" value="${ForwardConst.CMD_EDIT.getValue()}" />
<c:set var="commreEdt" value="${ForwardConst.CMD_REEDIT.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">

        <h2>日報 詳細ページ</h2>

        <table>
            <tbody>
                <tr>
                    <th>氏名</th>
                    <td><c:out value="${report.employee.name}" /></td>
                </tr>
                <tr>
                    <th>日付</th>
                    <fmt:parseDate value="${report.reportDate}" pattern="yyyy-MM-dd" var="reportDay" type="date" />
                    <td><fmt:formatDate value='${reportDay}' pattern='yyyy-MM-dd' /></td>
                </tr>
                <tr>
                    <th>タイトル</th>
                    <td><pre>
                            <c:out value="${report.title}" />
                        </pre></td>
                </tr>
                <tr>
                    <th>内容</th>
                    <td><pre><c:out value="${report.content}" /></pre></td>
                </tr>
                <tr>
                    <th>登録日時</th>
                    <fmt:parseDate value="${report.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="createDay" type="date" />
                    <td><fmt:formatDate value="${createDay}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <th>更新日時</th>
                    <fmt:parseDate value="${report.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="updateDay" type="date" />
                    <td><fmt:formatDate value="${updateDay}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <th>所属長承認</th>
                    <td>
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
                </tr>
                <tr>
                    <th>所属長コメント</th>
                    <td><pre><c:out value="${report.comment}" /></pre></td>
                </tr>

            </tbody>
        </table>

        <c:if test="${sessionScope.login_employee.id == report.employee.id}">
            <c:choose>
                <c:when test="${report.approval == '再提出'}">
                    <p>
                        <a href="<c:url value='?action=${actRep}&command=${commreEdt}&id=${report.id}' />">再提出する</a>
                    </p>
                </c:when>
                <c:otherwise>
                    <p>
                        <a href="<c:url value='?action=${actRep}&command=${commEdt}&id=${report.id}' />">この日報を編集する</a>
                    </p>
                </c:otherwise>
            </c:choose>
        </c:if>

        <p>
            <a href="<c:url value='?action=${actTop}&command=${commIdx}' />">一覧に戻る</a>
        </p>
    </c:param>
</c:import>



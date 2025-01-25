<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:if test="${not empty currentFile}">
    <li class="list-group-item">
        <c:choose>
            <c:when test="${currentFile.isDirectory}">
                <button class="btn btn-sm btn-link text-start" 
                        type="button" 
                        data-bs-toggle="collapse" 
                        data-bs-target="#collapse-${currentFile.path.hashCode()}" 
                        aria-expanded="false" 
                        aria-controls="collapse-${currentFile.path.hashCode()}">
                    <i class="bi bi-folder-fill"></i>
                    ${currentFile.name}
                </button>
                <div class="collapse" id="collapse-${currentFile.path.hashCode()}">
                    <ul class="list-group ms-3">
                        <c:forEach items="${currentFile.children}" var="child">
                            <c:set var="currentFile" value="${child}" scope="request" />
                            <jsp:include page="fileTreeNode.jsp" />
                        </c:forEach>
                    </ul>
                </div>
            </c:when>
            <c:otherwise>
                <i class="bi bi-file-earmark"></i>
                ${currentFile.name}
            </c:otherwise>
        </c:choose>
    </li>
</c:if>

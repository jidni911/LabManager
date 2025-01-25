<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container my-4">

    <!-- File Tree Section -->
    <div class="mb-4">
        <a
            class="btn btn-primary"
            data-bs-toggle="collapse"
            href="#contentId"
            aria-expanded="false"
            aria-controls="contentId"
        >
        File Tree
        </a>

        <div class="collapse" id="contentId">

            <ul class="list-group">
                <c:forEach items="${fileTree.children}" var="file">

                    <c:set var="currentFile" value="${file}" scope="request" />
                    <jsp:include page="fileTreeNode.jsp" />
                </c:forEach>
            </ul>

        </div>


    </div>



    <!-- Table: Hierarchical View -->
    <div class="table-responsive mb-4">

        <p>
            <a
                class="btn btn-primary"
                data-bs-toggle="collapse"
                href="#HFT"
                aria-expanded="false"
                aria-controls="HFT"
            >
            Hierarchical File Table
            </a>
        </p>
        <div class="collapse" id="HFT">
            <table class="table table-striped table-hover table-borderless align-middle">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Path</th>
                        <th>Is Directory</th>
                        <th>Is Safe</th>
                        <th>Children Count</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${fileTree.children}" var="file">
                        <tr>
                            <td>${file.name}</td>
                            <td>${file.path}</td>
                            <td>${file.isDirectory}</td>
                            <td>${file.isSafe}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${file.children != null}">
                                        ${file.children.size()}
                                    </c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>


    </div>

    <!-- Table: Flat List of All Files and Folders -->
    <div class="table-responsive">
        <h4>Flat File List</h4>
        <div class="btn-group mb-3 d-block text-center" role="group" aria-label="Quick Actions">

            
            
            <a 
                href="/file/markAllSafe"
                class="btn btn-outline-success"
                data-bs-toggle="tooltip"
                data-bs-placement="top"
                title="Everything visible is marked as safe, Invisible remains as it is"
            >
                Mark Visibles as Safe
            </a>
            <a 
                href="/file/markAllUnsafe" 
                class="btn btn-outline-danger"
                data-bs-toggle="tooltip"
                data-bs-placement="top"
                title="Both Visible and Invisible are marked as Unsafe"
            >   
                Mark All as Unsafe
            </a>
            <a 
                href="/file/markAllNoException" 
                class="btn btn-outline-secondary"
                data-bs-toggle="tooltip"
                data-bs-placement="top"
                title="Unhides Everything(Visible and Invisible)"
            >
                Mark All as no Exception
            </a>
            <a 
                href="/file/deleteAllUnsafe" 
                class="btn btn-outline-secondary"
                data-bs-toggle="tooltip"
                data-bs-placement="top"
                title="Delete the Visible Unsafe, Invisible remains as it is"
            >
                Delete All Unsafe
            </a>
        </div>
        <div class="btn-group mb-3 d-block text-center" role="group" aria-label="Quick Filters">
            <a href="#" class="btn btn-outline-success">Show Safe Only</a>
            <a href="#" class="btn btn-outline-danger">Show Unsafe Only</a>
            <a href="#" class="btn btn-outline-warning">Show Exceptions only</a>
            <a href="#" class="btn btn-outline-secondary">Show No Exceptions only</a>
        </div>
        <table class="table table-striped table-hover table-borderless align-middle">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Path</th>
                    <th>Is Directory</th>
                    <th colspan="2">Is Safe</th>
                    <th colspan="2">Is Exception</th>
                    <th colspan="2">Children Count</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${flatFileList}" var="file">
                    <tr>
                        <td>${file.name}</td>
                        <td>${file.path}</td>
                        <td>
                            <c:choose>
                                <c:when test="${file.isDirectory}">
                                    <i class="bi bi-check-circle-fill text-success"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-x-circle-fill text-danger"></i>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${file.isSafe}">
                                    <i class="bi bi-check-circle-fill text-success"></i>

                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-x-circle-fill text-danger"></i>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a class="btn btn-outline-warning" href='/file/safeToggle/${file.path.replace("\\", ",")}' role="button">
                                Toggle
                            </a>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${file.isException}">
                                    <i class="bi bi-check-circle-fill text-success"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-x-circle-fill text-danger"></i>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a class="btn btn-outline-warning" href='/file/exceptionToggle/${file.path.replace("\\", ",")}' role="button">
                                Toggle
                            </a>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${file.children != null}">
                                    ${file.children.size()}
                                </c:when>
                                <c:otherwise>0</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
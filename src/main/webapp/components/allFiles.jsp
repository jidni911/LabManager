<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
        #fileTree {
            max-height: 600px;
            overflow-y: auto;
        }

        iframe {
            background-color: #f8f9fa;
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <div class="container mt-4">
        <div class="d-flex justify-content-center">
            <h1 class="text-primary">All Files</h1>
        </div>

        <div class="d-flex justify-content-center mb-3">
            <c:forEach items="${drives}" var="drive">
                <c:if test="${drive == currentDrive}">
                    <a href="/drive/${drive}" class="btn btn-outline-success mx-2">${drive}</a>
                </c:if>
                <c:if test="${drive != currentDrive}">
                    <a href="/drive/${drive}" class="btn btn-outline-warning mx-2">${drive}</a>
                </c:if>
            </c:forEach>
        </div>

        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-4">
                <div class="list-group" id="fileTree">
                    <c:forEach items="${files}" var="file">
                        <c:choose>
                            <c:when test="${file.isDirectory()}">
                                <a href="/directory/${parentPath}${file.name}" class="list-group-item list-group-item-action">
                                <i class="bi bi-folder"></i> ${file.name}
                            </a>
                            </c:when>
                            <c:otherwise>
                                <a href="/file/${parentPath}${file.name}" class="list-group-item list-group-item-action" target="fileViewer">
                                <i class="bi bi-file-earmark"></i> ${file.name}
                            </a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </div>

            <!-- File Viewer -->
            <div class="col-md-8">
                <iframe id="fileViewer" src="" class="border rounded" frameborder="0" width="100%"
                    height="600"></iframe>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            document.querySelectorAll('#fileTree a').forEach(link => {
                link.addEventListener('click', (e) => {
                    const href = link.getAttribute('href');
                    const isFile = href.includes('/file/');
                    if (isFile) {
                        e.preventDefault();
                        document.getElementById('fileViewer').src = href;
                    }
                });
            });

           
        });
    </script>
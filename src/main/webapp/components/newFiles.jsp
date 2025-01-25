<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <div class="list-group">
        <c:forEach items="${drives}" var="drive">
            <button data-bs-toggle="collapse" href="#contentId${drive}" onclick="showContent('${drive}')"
                class="list-group-item list-group-item-action">${drive}</button>
            <div class="collapse" id="contentId${drive}">
                <div class="spinner-border text-primary" role="status" id="loading${drive}">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>
        </c:forEach>
    </div>

    <script>
        function showContent(drive) {
            const contentDiv = document.getElementById("contentId" + drive);
            const loader = document.getElementById("loading" + drive);

            // Show loading spinner
            loader.style.display = "block";

            // Fetch file list dynamically
            fetch(`/file/listAllFiles/` + drive + `,`)
                .then(response => response.text())
                .then(data => {
                    const files = JSON.parse(data);
                    contentDiv.innerHTML = files.map(file => {
                        return `<div class="text-` + (file.isDirectory ? 'warning' : 'info') + ` list-group-item list-group-item-action">
                        <i class="bi `+ (file.isDirectory ? 'bi-folder' : 'bi-file-earmark') + `"></i>
                        <a class="text-`+ (file.isDirectory ? 'warning' : 'info') + ` text-decoration-none"
                        data-bs-toggle="collapse"
                        href="#loading`+file.path+`">`+ file.name + `</a>
                        <span class="float-end">`+ file.path + `</span>
                    </div>
                    <div class="collapse" id="contentId`+file.path+`">
                        <div class="spinner-border text-primary" role="status" id="loading`+file.path+`">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>`;
                    }).join('');
                })
                .catch(error => {
                    contentDiv.innerHTML = "<div class='text-danger'>Error loading content.</div>";
                    console.error("Error fetching file list:", error);
                })
                .finally(() => {
                    // Hide loading spinner
                    loader.style.display = "none";
                });
        }
    </script>
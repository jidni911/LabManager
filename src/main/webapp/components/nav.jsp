<nav class="navbar navbar-expand-sm navbar-light bg-info pb-0">
    <div class="container">
        <span class="navbar-brand" >Lab Assistant</span>
        <button class="navbar-toggler d-lg-none" type="button" data-bs-toggle="collapse"
            data-bs-target="#collapsibleNavId" aria-controls="collapsibleNavId" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="collapsibleNavId">
            <ul class="navbar-nav nav-tabs me-auto mt-2 mt-lg-0" id="navId" role="tablist">
                <li class="nav-item">
                    <a href="#tab1Id" class="nav-link active" data-bs-toggle="tab">
                        Home
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#tab2Id" class="nav-link" data-bs-toggle="tab">
                        All Files
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#tab3Id" class="nav-link" data-bs-toggle="tab">
                        Safe Files
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#tab4Id" class="nav-link" data-bs-toggle="tab">
                        New Files
                    </a>
                </li>
                <li class="nav-item" >
                    <a href="#tab5Id" class="nav-link" data-bs-toggle="tab">
                        Helpfull Links
                    </a>
                </li>

            </ul>
            <div class="d-flex my-2 my-lg-0">
                <button class="btn btn-outline-success my-2 my-sm-0" onclick="toggleTheme()">
                    Theme
                </button>
                <script>
                    function toggleTheme() {
                        var element = document.body;
                        var theme = localStorage.getItem("theme") || "light";
                        if (theme === "light") {
                            element.setAttribute("data-bs-theme", "dark");
                            localStorage.setItem("theme", "dark");
                        } else {
                            element.removeAttribute("data-bs-theme");
                            localStorage.setItem("theme", "light");
                        }
                    }

                    var element = document.body;
                        var theme = localStorage.getItem("theme") || "light";
                        if (theme === "light") {
                            element.setAttribute("data-bs-theme", "light");
                        } else {
                            element.setAttribute("data-bs-theme", "dark");
                        }

                </script>
            </div>
        </div>
    </div>
</nav>
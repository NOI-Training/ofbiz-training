<#-- ============================================================
     Apache OFBiz — Global Error Page
     Clean • Human-readable • Safe
     ============================================================ -->

<#assign rawError  = request.getAttribute("_ERROR_MESSAGE_")!"" />
<#assign errorList = request.getAttribute("_ERROR_MESSAGE_LIST_")![] />

<#-- Default user-friendly message -->
<#assign finalMessage = "An unexpected error occurred. Please try again later." />

<#-- Friendly error detection -->
<#if rawError?contains("Unknown request")>
    <#assign finalMessage = "The page you requested does not exist." />

<#elseif rawError?contains("cannot be called directly")>
    <#assign finalMessage = "This action cannot be accessed directly. Please use the application menu." />

<#elseif rawError?contains("permission")
     || rawError?contains("Authorization")
     || rawError?contains("denied")>
    <#assign finalMessage = "You do not have permission to access this page." />

<#elseif rawError?contains("NoSuchMethodException")>
    <#assign finalMessage = "This feature is not available or not implemented yet." />

<#elseif errorList?has_content>
    <#assign finalMessage = errorList[0]!finalMessage />

<#elseif rawError?has_content>
    <#-- Remove technical prefix like: java.lang.IllegalArgumentException: -->
    <#assign finalMessage = rawError?replace("^.*?:", "", "r")?trim />
</#if>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Error</title>

<style>
* { box-sizing: border-box; }

body {
    margin: 0;
    height: 100vh;
    font-family: Inter, Arial, sans-serif;
    background: linear-gradient(135deg, #fee2e2, #e0e7ff);
    display: flex;
    align-items: center;
    justify-content: center;
}

/* MAIN CARD */
.card {
    display: flex;
    gap: 40px;
    width: 860px;
    padding: 44px;
    border-radius: 22px;
    background: rgba(255,255,255,0.96);
    box-shadow: 0 28px 60px rgba(0,0,0,0.18);
    animation: fadeUp .5s ease;
}

@keyframes fadeUp {
    from { opacity: 0; transform: translateY(20px); }
    to   { opacity: 1; transform: translateY(0); }
}

/* LEFT IMAGE */
.left-panel {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
}

.icon-wrapper {
    width: 260px;
    animation: floatError 3.5s ease-in-out infinite;
}

.icon-wrapper img {
    width: 100%;
    display: block;
    filter: drop-shadow(0 18px 35px rgba(239,68,68,0.3));
}

@keyframes floatError {
    0%   { transform: translateY(0); }
    50%  { transform: translateY(-12px); }
    100% { transform: translateY(0); }
}

/* RIGHT CONTENT */
.right-panel {
    flex: 1.2;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

h1 {
    color: #991B1B;
    font-size: 26px;
    margin-bottom: 14px;
}

/* MESSAGE BOX */
.message {
    margin: 16px 0 28px;
    padding: 18px 22px;
    border-radius: 12px;
    background: linear-gradient(
        135deg,
        rgba(37,99,235,0.08),
        rgba(99,102,241,0.05)
    );
    border-left: 5px solid #2563eb;
}

.message-text {
    font-size: 16px;
    font-weight: 600;
    line-height: 1.75;
    background: linear-gradient(90deg,#374151,#1e40af,#2563eb);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* ACTION BUTTONS */
.actions {
    margin-top: 10px;
    display: flex;
    gap: 14px;
    flex-wrap: wrap;
}

.actions a {
    padding: 12px 22px;
    border-radius: 10px;
    font-weight: 600;
    font-size: 15px;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 140px;
}

.home {
    background: #2563eb;
    color: #fff;
}
.home:hover { background: #1e40af; }

.back {
    background: #e5e7eb;
    color: #111827;
}
.back:hover { background: #d1d5db; }

/* FOOTER */
.footer {
    margin-top: 32px;
    font-size: 14px;
    font-weight: 600;
    background: linear-gradient(to right,#6b7280,#2563eb);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* MOBILE */
@media (max-width: 900px) {
    .card {
        flex-direction: column;
        text-align: center;
    }
    .actions {
        justify-content: center;
    }
}
</style>
</head>

<body>

<div class="card">

    <!-- LEFT IMAGE -->
    <div class="left-panel">
        <div class="icon-wrapper">
            <img src="<@ofbizContentUrl>/classroom-task/images/images-removebg-preview.png</@ofbizContentUrl>" />
        </div>
    </div>

    <!-- RIGHT CONTENT -->
    <div class="right-panel">
        <h1>Oops! Something went wrong</h1>

        <div class="message">
            <span class="message-text">${finalMessage}</span>
        </div>

        <div class="actions">
            <a class="home" href="<@ofbizUrl>main</@ofbizUrl>">🏠 Home</a>
            <a class="back" href="javascript:history.back()">↩ Go Back</a>
        </div>

        <div class="footer">
            Class Room Task Application — Kuldeep Jangid
        </div>
    </div>

</div>

</body>
</html>

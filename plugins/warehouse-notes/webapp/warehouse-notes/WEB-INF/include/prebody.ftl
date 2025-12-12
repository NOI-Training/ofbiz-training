<html>
  <head>
    <title>${layoutSettings.companyName!""}</title>
    <meta name="viewport" content="width=device-width, user-scalable=no"/>


    <#-- Load CSS -->
    <#list layoutSettings.styleSheets as styleSheet>
      <link rel="stylesheet" href="${StringUtil.wrapString(styleSheet)}" type="text/css"/>
    </#list>
  </head>
  <style>
/* --- Global Styles --- */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    background: #f5f6fa;
    font-family: "Inter", Arial, sans-serif;
    color: #222;
    overflow: hidden;
}

.container {
    flex: 1 0 auto;
    padding: 20px;
}

/* --- Top Navigation --- */
#page-title {
    list-style: none;
    margin: 0;
    padding: 20px 20px;
    background-color: #000;
    display: flex;
    align-items: center;
    border-radius: 6px;
    width: 100%;
}

/* Default nav items */
#page-title li {
    margin: 0 10px;
}

/* Left item stays on the left */
#page-title li:first-child {
    margin-right: auto;     /* push all other items to right */
}

/* Compact spacing for right-side items */
#page-title li.pull-right {
    margin-left: 18px;      /* small gap between Add / Find / Logout */
}

/* Link styling */
#page-title li a {
    color: #fff;
    font-weight: 600;
    padding: 6px 10px;
    text-decoration: none;
    border-radius: 4px;
    transition: 0.25s ease;
}

/* Hover */
#page-title li a:hover {
    background-color: #0d6efd;
    transform: translateY(-2px);
}

/* --- Footer --- */
footer {
    flex-shrink: 0;
    background: #000;
    color: #fff;
    text-align: center;
    padding: 18px 0;
    font-size: 14px;
    border-top: 2px solid #0d6efd;
}

/* --- Main Content Layout --- */
#main-content {
    margin-top: 20px;
    background: #fff;
    padding: 25px;
    border-radius: 8px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.08);
}

  </style>

  <body data-offset="125">
    <div class="container menus" id="container">
      <div class="row">
        <div class="col-sm-12">
          <ul id="page-title" class="breadcrumb">
          <li>
                <a href="<@ofbizUrl>main</@ofbizUrl>">Warehouse-Notes Portal</a>
          </li>
          <li class="pull-right">
               <a href="<@ofbizUrl>createNote</@ofbizUrl>">Add Notes</a>
          </li>
          <li class="pull-right">
               <a href="<@ofbizUrl>listNotes</@ofbizUrl>">Find Notes</a>
         </li>
          <li class="pull-right">
                <a href="<@ofbizUrl>logout</@ofbizUrl>" title="${uiLabelMap.CommonLogout}">logout</a>
          </li>
          </ul>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-12 header-col">
          <div id="main-content">

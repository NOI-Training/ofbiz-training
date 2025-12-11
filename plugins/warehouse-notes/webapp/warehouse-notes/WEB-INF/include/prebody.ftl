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
    /* --- Page Layout --- */
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      display: flex;
      flex-direction: column;
      font-family: Arial, sans-serif;
    }

    /* Make the container expand to fill available space */
    .container {
      flex: 1 0 auto;
    }

    /* --- Footer Styles --- */
    footer {
      flex-shrink: 0;
      background-color: black;
      color: white;
      text-align: center;
      padding: 15px 0;
      width: 100%;
      box-shadow: 0 -2px 5px rgba(0,0,0,0.3);
    }

    footer p {
      margin: 0;
      font-size: 14px;
    }

    /* --- Menu Bar Styles --- */
    #page-title {
      list-style: none;
      margin: 0;
      padding: 0;
      background-color: black;
      overflow: hidden;
      border-radius: 5px;
    }

    /* Style each menu item */
    #page-title li {
      float: left;
    }
    #page-title li h6 {
          display: block;
          color: white;
          text-align: center;
          padding: 10px 20px;
          text-decoration: none;
          font-weight: bold;
    }
    /* Style the links */
    #page-title li a {
      display: block;
      color: white;
      text-align: center;
      padding: 10px 20px;
      text-decoration: none;
      font-weight: bold;
    }

    /* Change link color on hover */
    #page-title li a:hover {
      background-color: #0056b3;
      color: #fff;
    }

    /* Pull-right item (logout) */
    #page-title li.pull-right {
      float: right;
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
                        <a href="<@ofbizUrl>logout</@ofbizUrl>" title="${uiLabelMap.CommonLogout}">logout</a>
          </li>
          <li class="pull-right">
                          <a href="<@ofbizUrl>listNotes</@ofbizUrl>">Find Notes</a>
          </li>
            <li class="pull-right">
                 <a href="<@ofbizUrl>createNote</@ofbizUrl>">Add Notes</a>
            </li>

          </ul>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-12 header-col">
          <div id="main-content">

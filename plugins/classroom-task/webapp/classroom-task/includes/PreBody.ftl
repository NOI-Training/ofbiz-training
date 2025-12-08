<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${uiLabelMap.ClsTaskApplication}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- External CSS -->
    <link rel="stylesheet" href="/classroom-task/css/style.css"/>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">

</head>

<body>

<!-- NAVBAR -->
<header class="navbar">
    <div class="nav-left">
        <span class="nav-title">📘 ${uiLabelMap.ClsTaskApplication}</span>
    </div>

    <nav class="nav-right">
        <a class="nav-link" href="<@ofbizUrl>FindClsTask</@ofbizUrl>">${uiLabelMap.ClsTaskMenuList}</a>
        <a class="nav-link" href="<@ofbizUrl>AddClsTask</@ofbizUrl>">${uiLabelMap.ClsTaskMenuAdd}</a>
        <a class="nav-link" href="<@ofbizUrl>UpdateClsTask</@ofbizUrl>">${uiLabelMap.ClsTaskMenuUpdate}</a>
        <a class="nav-link logout" href="<@ofbizUrl>logout</@ofbizUrl>">Logout</a>
    </nav>
</header>

<!-- BODY WRAPPER -->
<div class="page-container">

<#-- updateWnItemNote.ftl -->

<h2 class="title">Update Note</h2>

<style>
    .title {
        font-family: Arial, sans-serif;
        text-align: center;
        margin-bottom: 25px;
        font-weight: 600;
        color: #2c3e50;
    }

    .update-form-container {
        width: 60%;
        margin: auto;
        padding: 25px;
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0px 0px 15px rgba(0,0,0,0.15);
        font-family: Arial, sans-serif;
    }

    table.update-table {
        width: 100%;
        border-collapse: collapse;
    }

    table.update-table td {
        padding: 12px;
        font-size: 15px;
    }

    table.update-table tr td:first-child {
        width: 35%;
        font-weight: bold;
        color: #34495e;
        background: #f8f9fa;
    }

    input[type="text"], textarea, select {
        width: 100%;
        padding: 10px;
        border-radius: 6px;
        border: 1px solid #ccc;
        font-size: 14px;
        transition: .3s;
    }

    input[type="text"]:focus, textarea:focus, select:focus {
        border-color: #3498db;
        box-shadow: 0 0 5px rgba(52,152,219,0.4);
    }

    .btn-primary {
        background: #3498db;
        border: none;
        padding: 10px 25px;
        border-radius: 6px;
        font-size: 16px;
        color: white;
        cursor: pointer;
        transition: .3s;
    }

    .btn-primary:hover {
        background: #2980b9;
    }

    .center {
        text-align: center;
    }

    .error {
        color: red;
        text-align: center;
        font-size: 18px;
        margin-top: 25px;
    }
</style>

<#assign note = delegator.findOne("WnItemNote", {"noteId": parameters.noteId}, false) />

<#if note?has_content>
<div class="update-form-container">

<form method="post" action="<@ofbizUrl>updateNoteEvent</@ofbizUrl>">

    <input type="hidden" name="noteId" value="${note.noteId}" />

    <table class="update-table">
        <tr>
            <td>Inventory Item ID:</td>
            <td><input type="text" name="inventoryItemId" value="${note.inventoryItemId!}" required/></td>
        </tr>

        <tr>
            <td>Note Text:</td>
            <td><textarea name="noteText" cols="60" rows="5">${note.noteText!}</textarea></td>
        </tr>

        <tr>
            <td>Visible To Users:</td>
            <td>
                <select name="visibilityFlag">
                    <option value="" <#if note.visibilityFlag?string == "">selected</#if>>Select</option>
                    <option value="Y" <#if note.visibilityFlag?string == "Y">selected</#if>>Yes</option>
                    <option value="N" <#if note.visibilityFlag?string == "N">selected</#if>>No</option>
                </select>
            </td>
        </tr>

        <tr>
            <td colspan="2" class="center">
                <button type="submit" class="btn-primary">Update Note</button>
            </td>
        </tr>
    </table>

</form>

</div>

<#else>
    <p class="error">Invalid noteId</p>
</#if>
<style>
/* Container */
.notes-container {
    max-width: 1100px;
    margin: 30px auto;
    padding: 20px;
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    font-family: "Segoe UI", Arial, sans-serif;
}

/* Wrap both forms in a single row */
.search-form,
.create-form {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 20px;
}

.search-form {
    flex-wrap: wrap;
}

/* Make Create button next to Find button */
.create-form {
    margin-left: 10px;
}

/* Inputs */
.search-form label {
    font-weight: 600;
    color: #333;
}

.search-form input[type="text"] {
    padding: 8px 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    outline: none;
    font-size: 14px;
    transition: 0.2s;
}

.search-form input[type="text"]:focus {
    border-color: #000;
    box-shadow: 0 0 4px rgba(0,0,0,0.4);
}

/* BLACK BUTTONS */
.search-form button,
.create-form button,
.pagination a {
    background: #000;
    color: white;
    border: none;
    padding: 8px 14px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: 0.25s;
}

.search-form button:hover,
.create-form button:hover,
.pagination a:hover {
    background: #333;
}

/* Table */
.notes-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.notes-table thead {
    background: #f3f6fb;
}

.notes-table th,
.notes-table td {
    padding: 12px 14px;
    text-align: left;
    border-bottom: 1px solid #e5e5e5;
    font-size: 14px;
}

.notes-table tr:hover {
    background: #f9fbff;
}

/* Update/Delete Buttons */
.button-link,
.button-link-delete {
    padding: 6px 12px;
    border-radius: 6px;
    font-size: 13px;
    text-decoration: none;
    font-weight: 600;
    color: white;
    transition: 0.2s;
}

.button-link {
    background: #00a86b;
}

.button-link:hover {
    background: #008f5b;
}

.button-link-delete {
    background: #e63946;
}

.button-link-delete:hover {
    background: #c62834;
}

/* Pagination */
.pagination {
    margin-top: 20px;
    text-align: center;
    font-size: 15px;
    font-weight: 600;
}

.pagination a {
    margin: 0 5px;
    text-decoration: none;
}

</style>


<script>
function confirmDelete(noteId) {
    return confirm("Are you sure you want to delete Notes ID: " + noteId + " ?");
}
</script>
<div class="notes-container">
    <!-- Search Form -->
    <form class="search-form" name="FindNotes" method="post" action="findNotesEvent">
        <label for="inventoryItemId">Inventory Item ID:</label>
        <input type="text" id="inventoryItemId" name="inventoryItemId"/>
        <button type="submit">Find</button>
    </form>
    <form class="create-form" name="CreateNotes" method="post" action="createNote">
        <button type="submit">Create New Note</button>
    </form>
    <#-- Check if listIt exists before iterating -->
    <#if listIt?? && (listIt?size > 0)>
        <table class="notes-table">
            <thead>
                <tr>
                    <th>Note ID</th>
                    <th>Inventory Item ID</th>
                    <th>Note Text</th>
                    <th>Visibility</th>
                    <th>Update Note</th>
                    <th> Delete Notes</th>
                </tr>
            </thead>
            <tbody>
                <#list listIt as note>
                <tr>
                    <td>${note.noteId}</td>
                    <td>${note.inventoryItemId}</td>
                    <td>${note.noteText}</td>
                    <td>${note.visibilityFlag}</td>
                    <td>
                        <a class="button-link" href="updateVisibility?noteId=${note.noteId}">Update</a>
                    </td>
                    <td>
                        <a class="button-link-delete"
                              href="deleteWnItemNote?noteId=${note.noteId}"
                              onclick="return confirmDelete('${note.noteId}');">
                               Delete
                        </a>
                    </td>
                </tr>
                </#list>
            </tbody>
        </table>
    <#else>
        <p>No notes found.</p>
    </#if>
</div>
<#assign page = (page!1)?number>
<#assign totalPages = (totalPages!1)?number>

<div class="pagination">
    <#if page?has_content && (page?number > 1)>
        <a href="<@ofbizUrl>findNotesEvent?page=${page?number - 1}</@ofbizUrl>"><<</a>
    </#if>

    Page ${page!1} of ${totalPages!1}

    <#if page?has_content && totalPages?has_content && (page?number < totalPages?number)>
        <a href="<@ofbizUrl>findNotesEvent?page=${page?number + 1}</@ofbizUrl>">>></a>
    </#if>
</div>
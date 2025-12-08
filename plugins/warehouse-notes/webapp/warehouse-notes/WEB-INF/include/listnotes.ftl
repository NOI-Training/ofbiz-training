<style>
/* Container */
.notes-container {
    max-width: 900px;
    margin: 30px auto;
    font-family: Arial, sans-serif;
}

/* Search Form */
.search-form {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.search-form label {
    margin-right: 10px;
    font-weight: bold;
    color: #333;
}

.search-form input[type="text"] {
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
    flex: 1;
    margin-right: 10px;
    transition: border-color 0.3s;
}

.search-form input[type="text"]:focus {
    border-color: #007BFF;
    outline: none;
}

.search-form button {
    background-color: #007BFF;
    color: white;
    border: none;
    padding: 8px 12px;
    border-radius: 5px;
    cursor: pointer;
    display: flex;
    align-items: center;
    transition: background-color 0.3s;
}

.search-form button:hover {
    background-color: #0056b3;
}

.search-form button img {
    width: 16px;
    height: 16px;
    margin-right: 5px;
}

/* Notes Table */
.notes-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.notes-table th, .notes-table td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: left;
}

.notes-table th {
    background-color: #f4f6f8;
    font-weight: bold;
}

.notes-table tr:nth-child(even) {
    background-color: #fafafa;
}

.notes-table tr:hover {
    background-color: #f1f5f9;
}

.notes-table a {
    color: white;
    text-decoration: none;
}

.notes-table a:hover {
    text-decoration: underline;
}

.button-link {
    display: inline-block;
    padding: 5px 10px;
    background-color: #28a745;
    color: white;
    border-radius: 5px;
    text-decoration: none;
    font-size: 13px;
}

.button-link:hover {
    background-color: #218838;
}
</style>


<script>
function confirmDelete(noteId) {
    return confirm("Are you sure you want to delete NOtes ID: " + noteId + " ?");
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
                        <a class="button-link"
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

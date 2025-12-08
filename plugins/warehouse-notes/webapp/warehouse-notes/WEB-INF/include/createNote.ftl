<style>
/* Form Container */
.form-container {
    max-width: 600px;
    margin: 30px auto;
    background-color: #fff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 6px 15px rgba(0,0,0,0.1);
    font-family: Arial, sans-serif;
}

/* Form Header */
.form-container h2 {
    text-align: center;
    color: #333;
    margin-bottom: 25px;
}

/* Form Fields */
.form-container form {
    display: flex;
    flex-direction: column;
}

.form-container label {
    margin-bottom: 5px;
    font-weight: bold;
    color: #555;
}

.form-container input[type="text"],
.form-container textarea,
.form-container select {
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
    width: 100%;
    box-sizing: border-box;
    transition: border-color 0.3s;
}

.form-container input[type="text"]:focus,
.form-container textarea:focus,
.form-container select:focus {
    border-color: #007BFF;
    outline: none;
}

.form-container textarea {
    resize: vertical;
}

/* Submit Button */
.form-container button[type="submit"] {
    padding: 12px;
    background-color: #007BFF;
    color: white;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.form-container button[type="submit"]:hover {
    background-color: #0056b3;
}

/* Form Group */
.form-group {
    margin-bottom: 15px;
}
</style>

<div class="form-container">
    <h2>Create Item Note</h2>
    <form name="createNoteForm" method="post" action="createNoteSubmit">
        <div class="form-group">
            <label for="inventoryItemId">Inventory Item ID</label>
            <input type="text" id="inventoryItemId" name="inventoryItemId"/>
        </div>

        <div class="form-group">
            <label for="noteText">Note Text</label>
            <textarea id="noteText" name="noteText" cols="40" rows="4"></textarea>
        </div>

        <div class="form-group">
            <label for="visibilityFlag">Visible to Users?</label>
            <select id="visibilityFlag" name="visibilityFlag">
                <option value="">Select</option>
                <option value="Y">Yes</option>
                <option value="N">No</option>
            </select>
        </div>

        <button type="submit">Submit</button>
    </form>
</div>
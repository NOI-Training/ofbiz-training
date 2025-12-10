<style>
.update-form-container {
    max-width: 600px;
    margin: 30px auto;
    background: #ffffff;
    padding: 30px 68px;
    border-radius: 12px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.15);
}

.update-form-container h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #1E2A38;
}

/* FORM GROUP */
.form-group {
    margin-bottom: 16px;
}

.form-group label {
    display: block;
    margin-bottom: 6px;
    font-weight: 600;
    color: #374151;
}

.form-group input,
.form-group textarea {
    width: 100%;
    padding: 10px 12px;
    border-radius: 6px;
    border: 1px solid #D1D5DB;
    font-size: 14px;
}

.form-group textarea {
    resize: vertical;
    min-height: 80px;
}

/* READONLY FIELD */
.form-group input[readonly] {
    background: #F3F4F6;
    color: #6B7280;
}

/* BUTTON */
.update-btn {
 background: #1E2A38;
    color: white;
    border: none;
    padding: 12px;
    width: 100%;
    font-size: 15px;
    font-weight: 600;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.3s ease;
}

.update-btn:hover {
    background: #1D4ED8;
}
</style>

<div class="update-form-container">
    <h2>✏️ Update Classroom Task</h2>

    <form method="post" action="<@ofbizUrl>updateClsTask</@ofbizUrl>">

        <!-- Task ID (read-only) -->
        <div class="form-group">
            <label>Task ID</label>
            <input type="text" name="taskId"
                   value="${parameters.taskId!}"
                  readonly>
        </div>

        <!-- Title -->
        <div class="form-group">
            <label>Title</label>
            <input type="text" name="title"
                   value="${parameters.title!}"
                   placeholder="Update title">
        </div>

        <!-- Description -->
        <div class="form-group">
            <label>Description</label>
            <textarea name="description"
                      placeholder="Update description...">${parameters.description!}</textarea>
        </div>

        <!-- Assigned To -->
        <div class="form-group">
            <label>Assigned To</label>
            <input type="text" name="assignedTo"
                   value="${parameters.assignedTo!}"
                   placeholder="Update assignee">
        </div>

        <!-- Status -->
        <div class="form-group">
            <label>Status</label>
            <input type="text" name="statusId"
                   value="${parameters.statusId!}"
                   placeholder="PENDING / ACTIVE / DONE">
        </div>

        <!-- Due Date (user can change; left empty or you can pass formatted value later) -->
        <div class="form-group">
            <label>Due Date</label>
            <input type="date" name="dueDate">
        </div>


        <button class="update-btn" type="submit">✅ Update Task</button>

    </form>
</div>

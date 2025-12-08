<style>
/* ----- FORM LAYOUT ----- */
.task-form-container {
    max-width: 600px;
    margin: 30px auto;
    background: #ffffff;
    padding: 50px 68px;
    border-radius: 12px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.15);
}

.task-form-container h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #1E2A38;
}

/* ----- FORM GROUP ----- */
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

/* ----- BUTTON ----- */
.submit-btn {
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

.submit-btn:hover {
    background: #1D4ED8;
}
</style>

<div class="task-form-container">
    <h2>➕ Create Classroom Task</h2>

    <form method="post" action="<@ofbizUrl>createClsTask</@ofbizUrl>">

        <div class="form-group">
            <label>Task ID *</label>
            <input type="text" name="taskId" placeholder="Enter unique Task ID" required>
        </div>

        <div class="form-group">
            <label>Title *</label>
            <input type="text" name="title" placeholder="Enter task title" required>
        </div>

        <div class="form-group">
            <label>Description</label>
            <textarea name="description" placeholder="Task description"></textarea>
        </div>

        <div class="form-group">
            <label>Assigned To</label>
            <input type="text" name="assignedTo" placeholder="User name">
        </div>

        <div class="form-group">
            <label>Status</label>
            <input type="text" name="statusId" placeholder="PENDING / ACTIVE / DONE">
        </div>

        <div class="form-group">
            <label>Due Date</label>
            <input type="date" name="dueDate">
        </div>

        <!-- Optional but kept as you requested -->
        <div class="form-group">
            <label>Created Date</label>
            <input type="datetime-local" name="createdDate">
        </div>

        <div class="form-group">
            <label>Last Updated Date</label>
            <input type="datetime-local" name="lastUpdatedDate">
        </div>

        <button class="submit-btn" type="submit">✅ Create Task</button>

    </form>
</div>

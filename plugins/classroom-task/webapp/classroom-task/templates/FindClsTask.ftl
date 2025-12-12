<style>
/* CARD CONTAINER */
.search-card {
    max-width: 500px;
    margin: 25px auto;
    background: #ffffff;
    padding: 50px 105px;
    border-radius: 12px;
    box-shadow: 0 4px 14px rgba(0,0,0,0.12);
}

/* TITLE */
.search-card h2 {
    margin-bottom: 18px;
    color: #1E2A38;
    font-size: 18px;
    text-align: center;
}

/* VERTICAL FORM LAYOUT */
.search-row {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

/* LABELS */
.search-row label {
    font-weight: 600;
    margin-bottom: 6px;
    color: #374151;
    display: block;
}

/* INPUT FIELDS */
.search-row input {
    width: 100%;
    padding: 10px 12px;
    border-radius: 6px;
    border: 1px solid #D1D5DB;
    font-size: 14px;
}

/* SUBMIT BUTTON */
.search-btn {
    margin-top: 22px;
    width: 100%;
 background: #1E2A38;
    color: white;
    border: none;
    padding: 12px;
    border-radius: 8px;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.25s ease;
}

.search-btn:hover {
    background: #1D4ED8;
}
</style>

<div class="search-card">
    <h2>🔍 Find Classroom Tasks</h2>

    <form method="get" action="<@ofbizUrl>FindClsTask</@ofbizUrl>">

        <div class="search-row">

            <div>
                <label for="taskId">Task ID</label>
                <input id="taskId"
                       type="text"
                       name="taskId"
                       placeholder="Enter task ID"
                       value="${parameters.taskId!}">
            </div>

            <div>
                <label for="title">Title</label>
                <input id="title"
                       type="text"
                       name="title"
                       placeholder="Enter task title"
                       value="${parameters.title!}">
            </div>

            <div>
                <label for="assignedTo">Assigned To</label>
                <input id="assignedTo"
                       type="text"
                       name="assignedTo"
                       placeholder="Assigned user"
                       value="${parameters.assignedTo!}">
            </div>

        </div>

        <button class="search-btn" type="submit">
            🔍 Find Tasks
        </button>

    </form>
</div>

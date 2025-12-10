<style>
.table-card {
    max-width: 1200px;
    margin: 25px auto;
    background: #ffffff;
    padding: 18px 22px;
    border-radius: 12px;
    box-shadow: 0 4px 14px rgba(0,0,0,0.12);
}

.table-card table {
    width: 100%;
    border-collapse: collapse;
}

.table-card th, .table-card td {
    padding: 10px 12px;
    border-bottom: 1px solid #E5E7EB;
    font-size: 14px;
}

.table-card th {
    background: #1E2A38;
    color: #ffffff;
    text-align: left;
}

/* ACTION BUTTONS */
.action-group {
    display: flex;
    gap: 8px;
}

.action-btn {
    padding: 6px 12px;
    border-radius: 18px;
    font-size: 13px;
    text-decoration: none;
    font-weight: 600;
    color: #fff;
    display: inline-flex;
    align-items: center;
    gap: 4px;
}

.edit-btn { background: #F59E0B; }
.delete-btn { background: #EF4444; }

.edit-btn:hover { background: #D97706; }
.delete-btn:hover { background: #DC2626; }

/* PAGINATION BUTTONS */
.pagination {
    margin-top: 20px;
    text-align: center;
}

.pagination button {
    margin: 0 6px;
    padding: 6px 12px;
    background: #1E2A38;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    cursor: pointer;
}

.pagination button:disabled {
    background: #9CA3AF;
    cursor: not-allowed;
}
</style>

<script>
function confirmDelete(taskId) {
    return confirm("Are you sure you want to delete Task ID: " + taskId + " ?");
}
</script>

<div class="table-card">
    <h3>📋 Task List</h3>

    <#if taskList?? && taskList?size gt 0>

        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Assigned</th>
                <th>Status</th>
                <th>Due</th>
                <th>Created Date</th>
                <th>Last Updated Date</th>
                <th>Action</th>
            </tr>
            </thead>

            <tbody>
            <#list taskList as t>
                <tr>
                    <td>${t.taskId}</td>
                    <td>${t.title}</td>
                    <td>${t.assignedTo!"-"}</td>
                    <td>${t.statusId!"-"}</td>

                    <td>
                        <#if t.dueDate??>
                            ${t.dueDate?string("yyyy-MM-dd")}
                        <#else>-</#if>
                    </td>

                    <td>
                        <#if t.createdStamp??>
                            ${t.createdStamp?string("yyyy-MM-dd HH:mm:ss")}
                        <#else>-</#if>
                    </td>

                    <td>
                        <#if t.lastUpdatedStamp??>
                            ${t.lastUpdatedStamp?string("yyyy-MM-dd HH:mm:ss")}
                        <#else>-</#if>
                    </td>

                    <td>
                        <div class="action-group">
                            <a class="action-btn edit-btn"
                               href="<@ofbizUrl>updateClsTask?taskId=${t.taskId}</@ofbizUrl>">
                                ✏️ Edit
                            </a>

                            <a class="action-btn delete-btn"
                               href="<@ofbizUrl>deleteClsTask?taskId=${t.taskId}</@ofbizUrl>"
                               onclick="return confirmDelete('${t.taskId}')">
                                🗑 Delete
                            </a>
                        </div>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>

        <!-- PAGINATION CALCULATION -->
        <#assign listSize  = listSize!0>
        <#assign viewIndex = viewIndex!0>
        <#assign viewSize  = viewSize!10>

        <#assign totalPages = (listSize / viewSize)?ceiling />

        <!-- PAGINATION BUTTONS -->
        <#if listSize gt viewSize>
        <form method="get" class="pagination">

            <!-- PREVIOUS BUTTON -->
            <#if viewIndex gt 0>
                <button type="submit" name="viewIndex" value="${viewIndex - 1}">
                    ⬅ Previous
                </button>
            <#else>
                <button type="button" disabled>⬅ Previous</button>
            </#if>

            <input type="hidden" name="viewSize" value="${viewSize}"/>

            <!-- PAGE INFO -->
            <span>
                Page ${viewIndex + 1} of ${totalPages}
            </span>

            <!-- NEXT BUTTON -->
            <#if viewIndex + 1 lt totalPages>
                <button type="submit" name="viewIndex" value="${viewIndex + 1}">
                    Next ➡
                </button>
            <#else>
                <button type="button" disabled>Next ➡</button>
            </#if>

        </form>
        </#if>

    <#else>
        <p style="text-align:center;color:#6B7280;">No Records Found</p>
    </#if>
</div>

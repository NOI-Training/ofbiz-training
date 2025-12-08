package test.org;

import java.sql.Timestamp;
import java.util.*;

import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.base.util.UtilDateTime;
import org.apache.ofbiz.entity.*;
import org.apache.ofbiz.entity.condition.*;
import org.apache.ofbiz.service.*;

public class ClassroomTaskServices {

    private static final String MODULE = ClassroomTaskServices.class.getName();

    /* Parse date / datetime-local */
    private static Timestamp parseHtmlDate(String val) {
        if (val == null || val.trim().isEmpty()) return null;
        try {
            if (val.contains("T")) {
                return Timestamp.valueOf(val.replace("T", " ") + ":00");
            }
            return Timestamp.valueOf(val + " 00:00:00");
        } catch (Exception e) {
            Debug.logError("Bad date: " + val, MODULE);
            return null;
        }
    }

    /* CREATE */
    public static Map<String, Object> createClsTask(DispatchContext dctx, Map<String, ?> ctx) {

        // Get Delegator to interact with database
        Delegator delegator = dctx.getDelegator();

        // Read required parameters from input context
        String taskId = (String) ctx.get("taskId");
        String title = (String) ctx.get("title");

        // Validate mandatory fields
        if (taskId == null || title == null)
            return ServiceUtil.returnError("TaskId and Title required");

        // Check if task already exists
        try {
            if (delegator.findOne("ClsTask", false, "taskId", taskId) != null) {
                return ServiceUtil.returnError("Task already exists");
            }

            // Create empty GenericValue for ClsTask entity
            GenericValue gv = delegator.makeValue("ClsTask");
            gv.put("taskId", taskId);
            gv.put("title", title);
            gv.put("description", ctx.get("description"));
            gv.put("assignedTo", ctx.get("assignedTo"));
            gv.put("statusId", ctx.get("statusId"));
            gv.put("dueDate", parseHtmlDate((String) ctx.get("dueDate")));

            // Get current timestamp
            Timestamp now = UtilDateTime.nowTimestamp();

            // Set created date (input or current time)
            gv.put("createdDate",
                    parseHtmlDate((String) ctx.get("createdDate")) != null
                            ? parseHtmlDate((String) ctx.get("createdDate")) : now);

            // Set updated date (input or current time)
            gv.put("lastUpdatedDate",
                    parseHtmlDate((String) ctx.get("lastUpdatedDate")) != null
                            ? parseHtmlDate((String) ctx.get("lastUpdatedDate")) : now);

            // Insert record into database
            delegator.create(gv);

            // Return success response
            return ServiceUtil.returnSuccess();

        } catch (Exception e) {
            // Log exception
            Debug.logError(e, MODULE);
            // Return error response
            return ServiceUtil.returnError(e.getMessage());
        }
    }

    /* UPDATE */
    public static Map<String, Object> updateClsTask(DispatchContext dctx, Map<String, ?> ctx) {
        Delegator delegator = dctx.getDelegator();

        try {
            // Find existing task by primary key
            GenericValue gv = delegator.findOne("ClsTask", false, "taskId", ctx.get("taskId"));

            // If task not found, return error
            if (gv == null) return ServiceUtil.returnError("Task not found");

            // Update fields
            gv.put("title", ctx.get("title"));
            gv.put("description", ctx.get("description"));
            gv.put("assignedTo", ctx.get("assignedTo"));
            gv.put("statusId", ctx.get("statusId"));
            gv.put("dueDate", parseHtmlDate((String) ctx.get("dueDate")));

            // Update lastUpdatedDate
            gv.put("lastUpdatedDate",
                    parseHtmlDate((String) ctx.get("lastUpdatedDate")) != null
                            ? parseHtmlDate((String) ctx.get("lastUpdatedDate"))
                            : UtilDateTime.nowTimestamp());

            // Save changes to database
            gv.store();
            return ServiceUtil.returnSuccess();

        } catch (Exception e) {
            return ServiceUtil.returnError(e.getMessage());
        }
    }

    /* DELETE */
    public static Map<String, Object> deleteClsTask(DispatchContext dctx, Map<String, ?> ctx) {
        try {
            // Find task by primary key
            GenericValue gv = dctx.getDelegator()
                    .findOne("ClsTask", false, "taskId", ctx.get("taskId"));

            // If record exists, remove it
            if (gv != null) gv.remove();

            // Return success
            return ServiceUtil.returnSuccess();
        } catch (Exception e) {
            return ServiceUtil.returnError(e.getMessage());
        }
    }

    /* FIND */
    public static Map<String, Object> findClsTask(DispatchContext dctx, Map<String, ?> ctx) {
        Delegator delegator = dctx.getDelegator();

        // List to hold search conditions
        List<EntityCondition> conds = new ArrayList<>();

        String taskId = (String) ctx.get("taskId");
        String title = (String) ctx.get("title");
        String assignedTo = (String) ctx.get("assignedTo");

        // Add condition if taskId provided
        if (taskId != null && !taskId.trim().isEmpty()) {
            conds.add(EntityCondition.makeCondition("taskId", taskId.trim()));
        }

        // Add LIKE condition for title
        if (title != null && !title.trim().isEmpty()) {
            conds.add(EntityCondition.makeCondition(
                    "title", EntityOperator.LIKE, "%" + title.trim() + "%"));
        }

        // Add condition for assignedTo
        if (assignedTo != null && !assignedTo.trim().isEmpty()) {
            conds.add(EntityCondition.makeCondition("assignedTo", assignedTo.trim()));
        }

        try {
            // Fetch list from database
            List<GenericValue> list = delegator.findList(
                    "ClsTask",
                    conds.isEmpty() ? null : EntityCondition.makeCondition(conds, EntityOperator.AND),
                    null, null, null, false);

            // Prepare success response
            Map<String, Object> res = ServiceUtil.returnSuccess();
            // Attach result list
            res.put("taskList", list);
            return res;

        } catch (Exception e) {
            return ServiceUtil.returnError(e.getMessage());
        }
    }


    /* SECA logging */
    public static Map<String, Object> logClsTaskStatusChange(DispatchContext dctx, Map<String, ? extends Object> context) {

        // Extract taskId from context
        String taskId = (String) context.get("taskId");

        // Log successful update information
        Debug.logInfo("=================================SECA: Task [" + taskId + "] Update Successfully ======================================", MODULE);

        // Return success
        return ServiceUtil.returnSuccess();
    }
    public static Map<String, Object> logClsTaskStatusCreate(DispatchContext dctx,
                                                             Map<String, Object> context) {

        String taskId = (String) context.get("taskId");

        Debug.logInfo("=======================EECA✅ ClsTask created successfully. ID = " + taskId,
                "CLASSROOM_TASK_ECA===============================");

        return ServiceUtil.returnSuccess();
    }

}

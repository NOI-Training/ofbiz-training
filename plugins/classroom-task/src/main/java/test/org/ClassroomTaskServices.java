package test.org;

import java.util.*;

import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.entity.Delegator;
import org.apache.ofbiz.entity.GenericValue;
import org.apache.ofbiz.entity.condition.EntityCondition;
import org.apache.ofbiz.entity.condition.EntityOperator;
import org.apache.ofbiz.service.DispatchContext;
import org.apache.ofbiz.service.ServiceUtil;

public class ClassroomTaskServices {

    private static final String MODULE = ClassroomTaskServices.class.getName();

    /* --------------------------------------------------
   CREATE TASK
   Default OFBiz stamp fields (createdStamp, createdDate,
   lastUpdatedStamp, etc.) are automatically populated
-------------------------------------------------- */
    public static Map<String, Object> createClsTask(
            DispatchContext dctx, Map<String, ?> context) {

        Delegator delegator = dctx.getDelegator();

        try {
            // ✅ Auto-generate primary key using OFBiz Sequencer
            String taskId = delegator.getNextSeqId("ClsTask");

            GenericValue gv = delegator.makeValue("ClsTask");

            gv.put("taskId", taskId);
            gv.put("title", context.get("title"));
            gv.put("description", context.get("description"));
            gv.put("assignedTo", context.get("assignedTo"));
            gv.put("statusId", context.get("statusId"));
            gv.put("dueDate", context.get("dueDate"));

            // ✅ Create record
            delegator.create(gv);

            // ✅ Prepare response
            Map<String, Object> result = ServiceUtil.returnSuccess();
            result.put("taskId", taskId);
            return result;

        } catch (Exception e) {
            Debug.logError(e, MODULE);
            return ServiceUtil.returnError(e.getMessage());
        }
    }

    /* --------------------------------------------------
       UPDATE TASK
       ✅ lastUpdatedDate / lastUpdatedStamp handled automatically
    -------------------------------------------------- */
    public static Map<String, Object> updateClsTask(
            DispatchContext dctx, Map<String, ?> context) {

        Delegator delegator = dctx.getDelegator();

        try {
            GenericValue task = delegator.findOne(
                    "ClsTask", false, "taskId", context.get("taskId"));

            if (task == null) {
                return ServiceUtil.returnError("Task not found");
            }

            task.put("title", context.get("title"));
            task.put("description", context.get("description"));
            task.put("assignedTo", context.get("assignedTo"));
            task.put("statusId", context.get("statusId"));
            task.put("dueDate", context.get("dueDate"));

            // ✅ CORRECT OFBiz API
            task.store();

            return ServiceUtil.returnSuccess();
        } catch (Exception e) {
            Debug.logError(e, MODULE);
            return ServiceUtil.returnError(e.getMessage());
        }
    }

    /* --------------------------------------------------
       DELETE TASK
    -------------------------------------------------- */
    public static Map<String, Object> deleteClsTask(
            DispatchContext dctx, Map<String, ?> context) {

        Delegator delegator = dctx.getDelegator();

        try {
            GenericValue task = delegator.findOne(
                    "ClsTask", false, "taskId", context.get("taskId"));

            if (task != null) {
                task.remove();
            }
            return ServiceUtil.returnSuccess();
        } catch (Exception e) {
            Debug.logError(e, MODULE);
            return ServiceUtil.returnError(e.getMessage());
        }
    }

    /* --------------------------------------------------
       FIND TASKS
       ✅ All default stamp fields returned automatically:
       createdDate, lastUpdatedDate,
       createdStamp, createdTxStamp,
       lastUpdatedStamp, lastUpdatedTxStamp
    -------------------------------------------------- */
    public static Map<String, Object> findClsTask(
            DispatchContext dctx, Map<String, ?> context) {

        Delegator delegator = dctx.getDelegator();
        List<EntityCondition> conditions = new ArrayList<>();

        String taskId = (String) context.get("taskId");
        String title = (String) context.get("title");
        String assignedTo = (String) context.get("assignedTo");

        if (taskId != null && !taskId.trim().isEmpty()) {
            conditions.add(EntityCondition.makeCondition("taskId", taskId.trim()));
        }
        if (title != null && !title.trim().isEmpty()) {
            conditions.add(EntityCondition.makeCondition(
                    "title", EntityOperator.LIKE, "%" + title.trim() + "%"));
        }
        if (assignedTo != null && !assignedTo.trim().isEmpty()) {
            conditions.add(EntityCondition.makeCondition("assignedTo", assignedTo.trim()));
        }

        // ✅ Pagination defaults
        Integer viewIndex = (Integer) context.get("viewIndex");
        Integer viewSize = (Integer) context.get("viewSize");

        if (viewIndex == null || viewIndex < 0) viewIndex = 0;
        if (viewSize == null || viewSize <= 0) viewSize = 5;   // 👈 keep small to see buttons

        int lowIndex = viewIndex * viewSize;

        try {
            // ✅ Full list (for listSize)
            List<GenericValue> fullList = delegator.findList(
                    "ClsTask",
                    conditions.isEmpty() ? null :
                            EntityCondition.makeCondition(conditions, EntityOperator.AND),
                    null, null, null, false);

            int listSize = fullList.size();

            // ✅ Sorted list
            List<GenericValue> sortedList = delegator.findList(
                    "ClsTask",
                    conditions.isEmpty() ? null :
                            EntityCondition.makeCondition(conditions, EntityOperator.AND),
                    null,
                    Arrays.asList("lastUpdatedStamp DESC"),
                    null,
                    false);

            int highIndex = Math.min(lowIndex + viewSize, listSize);
            List<GenericValue> taskList =
                    (lowIndex < highIndex) ? sortedList.subList(lowIndex, highIndex) : new ArrayList<>();

            Map<String, Object> result = ServiceUtil.returnSuccess();
            result.put("taskList", taskList);
            result.put("listSize", listSize);
            result.put("viewIndex", viewIndex);
            result.put("viewSize", viewSize);

            return result;

        } catch (Exception e) {
            Debug.logError(e, MODULE);
            return ServiceUtil.returnError(e.getMessage());
        }
    }

    /* --------------------------------------------------
       SECA / EECA LOGGING
    -------------------------------------------------- */
    public static Map<String, Object> logClsTaskStatusCreate(
            DispatchContext dctx, Map<String, ?> context) {

        Debug.logInfo("================================ ClsTask created. ID = " + context.get("taskId")+"=============================", MODULE);
        return ServiceUtil.returnSuccess();
    }

    public static Map<String, Object> logClsTaskStatusChange(
            DispatchContext dctx, Map<String, ?> context) {

        Debug.logInfo("============================= ClsTask updated. ID = " + context.get("taskId")+"=============================", MODULE);
        return ServiceUtil.returnSuccess();
    }
    public static Map<String, Object> JobScheduler(
            DispatchContext dctx,
            Map<String, ? extends Object> context) {

        System.out.println("==================================");
        System.out.println("Your Job Scheduler Runs Successfully In Backend Tasks");
        System.out.println("==================================");

        return ServiceUtil.returnSuccess();
    }

}

package com.companyname.service;

import java.util.Map;
import java.util.HashMap;
import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.base.util.UtilDateTime;
import org.apache.ofbiz.base.util.UtilMisc;
import org.apache.ofbiz.entity.GenericValue;
import org.apache.ofbiz.service.DispatchContext;
import org.apache.ofbiz.entity.Delegator;
import org.apache.ofbiz.entity.GenericEntityException;
import org.apache.ofbiz.service.ServiceUtil;

import java.util.ArrayList;
import java.util.List;

public class WnItemNoteServices {

    public static final String module = WnItemNoteServices.class.getName();

    public static Map<String, Object> createWnItemNote(DispatchContext dctx, Map<String, ? extends Object> context) {

        Map<String, Object> result = new HashMap<>();
        org.apache.ofbiz.entity.Delegator delegator = dctx.getDelegator();

        try {
            String inventoryItemId = (String) context.get("inventoryItemId");
            String noteText = (String) context.get("noteText");
            String visibilityFlag = (String) context.get("visibilityFlag");

            if (visibilityFlag == null) {
                visibilityFlag = "Y";
            }

            // Generate Primary Key
            String noteId = delegator.getNextSeqId("WnItemNote");

            // Create Value Object
            GenericValue note = delegator.makeValue("WnItemNote", UtilMisc.toMap(
                    "noteId", noteId,
                    "inventoryItemId", inventoryItemId,
                    "noteText", noteText,
                    "visibilityFlag", visibilityFlag,
                    "createdDate", UtilDateTime.nowTimestamp(),
                    "lastUpdatedDate", UtilDateTime.nowTimestamp()
            ));

            // Store to DB
            delegator.create(note);

            // return success + redirect URL
            result.put("noteId", noteId);
            result.put("responseMessage", "success");
            result.put("successMessage", "Note created successfully!");

            // <<< === ADD YOUR SUCCESS REDIRECT URL HERE === >>>
            result.put("successUrl", "viewWnItemNote?noteId=" + noteId);

            return result;

        } catch (Exception e) {
            e.printStackTrace();

            result.put("responseMessage", "error");
            result.put("errorMessage", "Unable to create WnItemNote: " + e.getMessage());
            return result;
        }
    }

    public static Map<String, Object> findNotes(DispatchContext dctx, Map<String, ? extends Object> context) {
        Delegator delegator = dctx.getDelegator();
        Map<String, Object> result = ServiceUtil.returnSuccess();

        try {
            String inventoryItemId = (String) context.get("inventoryItemId");
            List<GenericValue> notes;

            // Fetch notes based on inventoryItemId (or all if null/empty)
            if (inventoryItemId != null && !inventoryItemId.isEmpty()) {
                notes = delegator.findByAnd(
                        "WnItemNote",
                        Map.of("inventoryItemId", inventoryItemId),
                        null,   // orderBy
                        false   // useCache
                );
            } else {
                notes = delegator.findAll("WnItemNote", false);
            }

            // Map only the fields needed for the list form
            List<Map<String, Object>> cleanList = new ArrayList<>();
            for (GenericValue note : notes) {
                Map<String, Object> map = new HashMap<>();
                map.put("noteId", note.get("noteId"));
                map.put("inventoryItemId", note.get("inventoryItemId"));
                map.put("noteText", note.get("noteText"));
                map.put("visibilityFlag", note.get("visibilityFlag"));
                cleanList.add(map);
            }
            result.put("listIt", cleanList);

        } catch (GenericEntityException e) {
            return ServiceUtil.returnError("Error finding notes: " + e.getMessage());
        }

        return result;
    }

    public static Map<String, Object> updateNote(DispatchContext dctx, Map<String, ? extends Object> context) {

        Delegator delegator = dctx.getDelegator();
        Map<String, Object> result = ServiceUtil.returnSuccess();

        String noteId = (String) context.get("noteId");
        String noteText = (String) context.get("noteText");
        String visibilityFlag = (String) context.get("visibilityFlag");

        try {
            if (noteId == null) {
                return ServiceUtil.returnError("noteId is required to update note.");
            }

            GenericValue note = delegator.findOne("WnItemNote",
                    UtilMisc.toMap("noteId", noteId), false);

            if (note == null) {
                return ServiceUtil.returnError("Note not found for noteId: " + noteId);
            }

            // Update allowed fields
            if (noteText != null) note.set("noteText", noteText);
            if (visibilityFlag != null) note.set("visibilityFlag", visibilityFlag);

            note.set("lastUpdatedDate", UtilDateTime.nowTimestamp());
            note.store();

            result.put("successMessage", "Note updated successfully.");
            return result;

        } catch (Exception e) {
            return ServiceUtil.returnError("Failed to update note: " + e.getMessage());
        }
    }
    public static Map<String, Object> printEcaTriggered(DispatchContext dctx,
                                                        Map<String, ? extends Object> context) {
        Debug.logInfo("=============================ECA is triggered for Note create!=================================", "Warehouse Notes");
        return ServiceUtil.returnSuccess();
    }
    public static Map<String, Object> logVisibilityChange(DispatchContext dctx,
                                                          Map<String, ? extends Object> context) {
        String noteId = (String) context.get("noteId");
        String visibility = (String) context.get("visibilityFlag");

        Debug.logInfo("==================Visibility for noteId " + noteId + " changed to " + visibility+"=========================", "WarehouseNotes");

        return ServiceUtil.returnSuccess();
    }
    public static Map<String, Object> deleteWnItemNote(DispatchContext dctx, Map<String, ? extends Object> context) {

        Map<String, Object> result = new HashMap<>();
        Delegator delegator = dctx.getDelegator();

        try {
            String noteId = (String) context.get("noteId");

            if (noteId == null || noteId.isEmpty()) {
                result.put("responseMessage", "error");
                result.put("errorMessage", "noteId is required for deletion.");
                return result;
            }

            // Find the record
            GenericValue note = delegator.findOne("WnItemNote", UtilMisc.toMap("noteId", noteId), false);

            if (note == null) {
                result.put("responseMessage", "error");
                result.put("errorMessage", "Note not found for noteId: " + noteId);
                return result;
            }

            // Delete record
            note.remove();

            result.put("responseMessage", "success");
            result.put("successMessage", "Note deleted successfully!");

            // Optional: Redirect to list page
            result.put("successUrl", "listWnItemNotes");

            return result;

        } catch (Exception e) {
            e.printStackTrace();
            result.put("responseMessage", "error");
            result.put("errorMessage", "Unable to delete WnItemNote: " + e.getMessage());
            return result;
        }
    }

}
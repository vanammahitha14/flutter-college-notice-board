# College Notice Board – Defect & Robustness Test Log

This document records the robustness test cases, identified vulnerabilities, and preventative architectural fixes implemented for **CampusConnect – College Notice Board**, as required by the project specification.

---

## 📋 Defect Log Table

| Defect ID | Problem | Steps to Reproduce | Root Cause / Analysis | Resolution / Fix Applied | Status |
| :---: | :--- | :--- | :--- | :--- | :---: |
| **D01** | Empty notice list displays blank or unhandled screen | 1. Clear app storage.<br>2. Launch app.<br>3. Inspect home screen. | Absence of an explicit empty state branch in UI tree led to an empty, unhelpful blank screen. | Implemented a dedicated empty-state widget inside `HomeScreen` featuring an illustrative icon (`Icons.campaign_outlined`), helpful prompt, and an inline **Add Notice** CTA button. | **Fixed** |
| **D02** | Long text causes render overflow in list and details | 1. Enter notice title > 150 chars.<br>2. Enter description > 1000 chars.<br>3. Inspect cards and detail view. | Unbounded text in cards caused vertical pixel overflows (`A RenderFlex overflowed by ... pixels`). | Wrapped `NoticeCard` titles and snippets with `maxLines: 2` and `overflow: TextOverflow.ellipsis`. Enclosed `NoticeDetailScreen` and `AddNoticeScreen` within a `SingleChildScrollView`. | **Fixed** |
| **D03** | Notice does not persist when device is offline | 1. Turn off Wi-Fi & cellular data.<br>2. Create and publish a notice.<br>3. Force stop and restart the app. | Relying on live remote APIs without local caching causes data loss in disconnected environments. | Implemented local persistent key-value storage using `SharedPreferences` (`college_notices` key) with JSON serialization. The app operates with 100% offline autonomy. | **Fixed** |
| **D04** | Multiple duplicate notices created by rapid repeated taps | 1. Open Add Notice screen.<br>2. Fill valid notice data.<br>3. Tap Submit button rapidly 3–4 times. | Asynchronous `_saveNotices()` allowed subsequent tap events to trigger before the first execution completed. | Introduced an `_isSubmitting` guard boolean that immediately disables the submit button (`onPressed: _isSubmitting ? null : _submitNotice`) and rejects subsequent calls until completion. | **Fixed** |
| **D05** | Screen layout breaks / overflows after screen rotation | 1. Open Add Notice or Detail screen.<br>2. Rotate device to landscape.<br>3. Inspect for layout distortion or keyboard overlap. | Fixed height columns without scroll containers overflow when screen height decreases in landscape or when virtual keyboard appears. | All form screens, details, and filtered views are wrapped in scrolling containers (`SingleChildScrollView` and `ListView`) with flexible layouts. | **Fixed** |

---

## 🧪 Robustness Testing Summary

- **Total Test Cases:** 5
- **Passed:** 5
- **Failed:** 0
- **Fixed & Verified:** 5
- **QA & Defect Log Lead:** Tenali Koushik ([@koushiktenali11382006](https://github.com/koushiktenali11382006) • `248x1a12e0@khitguntur.ac.in`)

---

## 📝 Detailed Test Execution Results

### Test 1 – Empty Notice List Handling
- **Action:** Cleared local storage mock, launched `HomeScreen`.
- **Observed:** Correct empty state displayed (`"No notices available"`, `"Add your first college notice using the button below."`). No crashes or unhandled exceptions.
- **Result:** **PASS**

### Test 2 – Extreme Text Length
- **Action:** Submitted notice with 120-character title and 2,000-character description.
- **Observed:** Home feed card cleanly truncated with ellipsis (`...`). Details screen scroll smoothly without visual clipping or `RenderFlex` exceptions.
- **Result:** **PASS**

### Test 3 – No Internet / Complete Offline Independence
- **Action:** Tested with network connectivity disabled.
- **Observed:** Notices successfully encoded to JSON and stored locally via `SharedPreferences`. Fully retained and restored after complete application restart.
- **Result:** **PASS**

### Test 4 – Double-Tap / Rapid Multi-Tap Mitigation
- **Action:** Spammed the **Publish Notice** button repeatedly.
- **Observed:** Button immediately transitioned to loading state (`_isSubmitting = true`), disabling duplicate clicks. Exactly 1 notice was written to state and disk.
- **Result:** **PASS**

### Test 5 – Device Orientation Rotation
- **Action:** Toggled orientation between Portrait and Landscape across all four screens.
- **Observed:** UI adjusted responsively; department horizontal chips scrolled smoothly; forms handled virtual keyboard appearance with zero yellow-and-black overflow warnings.
- **Result:** **PASS**

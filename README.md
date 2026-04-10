# 📱 Offline-First Notes App (Flutter)

## 🚀 Overview
This project is a Flutter-based Notes application designed with an **offline-first architecture**.  
It ensures that users can **read and write data without internet connectivity**, while maintaining reliable synchronization with the backend.

---

## 🎯 Objective
To demonstrate:
- Local-first user experience
- Offline write handling
- Reliable sync with queue + retry
- Idempotency and conflict handling
- Observability through logs

---

---

## ⚙️ Tech Stack

- Flutter (UI)
- Hive (Local Storage)
- Provider (State Management)
- UUID (Unique ID generation)

---

## ✨ Features

### ✅ Local-first UX
- Notes are loaded instantly from local storage (Hive)
- No loading delay on app start

### ✅ Offline Writes
- Users can add/delete notes without internet
- Actions are stored in a persistent queue

### ✅ Sync Queue
- All offline actions are queued
- Queue persists across app restarts

### ✅ Retry Mechanism
- Failed requests are retried once with delay
- Retry limit ensures no infinite loops

### ✅ Idempotency
- Each operation uses a unique ID
- Prevents duplicate entries during retries

### ✅ Conflict Handling
- Implemented **Last Write Wins**
- Simpler and suitable for note-based systems

### ✅ Observability
- Logs include:
  - Queue size
  - Sync success/failure
  - Retry attempts

### ✅ UI Indicators
- 🟡 Pending (sync in progress)
- 🔴 Failed (retry available)
- 🟢 Synced (completed)

---

## 🧪 Verification Scenarios

### 📌 Offline Add Note
- Turn OFF internet
- Add note
- Note appears instantly
- Queue size increases

### 📌 Offline Delete Note
- Turn OFF internet
- Delete note
- Removed from UI
- Added to queue

### 📌 Retry Scenario
- Simulated API failure
- Retry triggered
- Logs show retry attempts
- No duplicate entries

### 📌 Logs Example

---

## 🔁 Sync Flow

1. User performs action (add/delete)
2. Action stored locally
3. Action added to queue
4. Background sync triggered
5. On success → removed from queue
6. On failure → retried once

---

## ⚖️ Trade-offs

| Decision | Reason |
|--------|--------|
| Hive instead of SQLite | Faster and simpler for key-value data |
| Last-write-wins | Avoids complex merge conflicts |
| Mock API | Simplifies testing of retry logic |

---

## 🚧 Limitations

- No real backend (mock API used)
- No edit/update note feature
- Retry limit is fixed (can be improved)
- No conflict resolution UI

---

## 🔮 Future Improvements

- Add edit note with conflict resolution
- Use Firebase as real backend
- Implement exponential backoff
- Add unit tests for queue logic
- Add TTL for cached data

---

## 🤖 AI Usage

AI tools were used to:
- Design architecture
- Implement queue and retry logic
- Optimize performance
- Improve UI and UX

All outputs were reviewed, tested, and modified where necessary.

---

## 📊 AI Prompt Log

### 1) Prompt:
- How to implement offline-first architecture in Flutter?

**Summary:**
Suggested using local DB + sync queue

**Decision:** Accepted  
**Why:** Matches real-world architecture

---

### 2) Prompt:
- How to implement retry mechanism with idempotency?

**Summary:**
Use unique IDs and retry counters

**Decision:** Modified  
**Why:** Simplified retry logic for assignment

---

### 3) Prompt:
- Improve UI for notes app

**Summary:**
Suggested card-based layout

**Decision:** Accepted  
**Why:** Better UX and readability

---

## ▶️ Run Instructions

```bash
flutter pub get
flutter run


# Studyora

## 📘 Project Overview

**Studyora** is an AI-powered academic study companion designed to help students plan, manage, and improve their learning process. The application combines intelligent study assistance, smart notifications, and performance analysis to support students throughout their academic journey.

This project is developed as a **purely academic project** at **The ICT University**, targeting primarily **secondary school and university students**, while remaining useful to all learners.

---

## 🎯 Objectives

* Assist students with AI-driven study support
* Improve academic consistency through smart reminders
* Provide intelligent summaries and insights from study notes
* Encourage focused learning and collaboration

---

## 👥 Team & Roles

### Project Owner & CTO

**Tomi Kologni Leyla Kevine**

* HND in Industrial Computing and Automation
* BSc in Artificial Intelligence (ongoing), The ICT University
* Responsibilities:

  * System architecture design
  * Mobile application development (Flutter)
  * Backend integration
  * DevOps coordination and deployment planning

### Scrum Master & Developer

**Messi Ngandi Joseph Desire**

* BSc in Software Engineering, The ICT University
* Responsibilities:

  * Agile project coordination (Scrum)
  * AI service development and integration
  * Backend API collaboration

---

## 🧠 System Architecture Overview

Studyora is built using a **modular microservice-inspired architecture**:

* **Flutter Mobile App**: User interface, notifications, and interaction layer
* **Main Backend (Node.js + PostgreSQL)**:

  * User management
  * Study groups
  * Notifications logic
* **AI Microservice (FastAPI – Python)**:

  * Study assistant Q&A
  * Notes summarization
  * Study plan generation
  * Performance prediction
* **Messaging Layer (Kafka)**:

  * Event-based communication
  * Decoupling AI and core backend services
* **Notification Service (Firebase Cloud Messaging)**:

  * Push notifications
* **Deployment**:

  * VPS-based deployment using Docker containers

---

## 🚀 Features

* AI-powered study assistant (Q&A)
* Intelligent study plan generation
* AI-based performance and academic risk prediction
* Notes summarization
* Smart notifications (missed sessions, reminders, risk alerts)
* Focus mode to reduce distractions
* Study groups (manual and AI-suggested)
* User profiles with image upload

---

## 🛠️ Technology Stack

### Frontend

* Flutter (Android-first)

### Backend

* Node.js
* PostgreSQL

### AI Service

* Python (FastAPI)

### Messaging & Notifications

* Apache Kafka
* Firebase Cloud Messaging (FCM)

### Deployment

* Docker
* VPS (Virtual Private Server)

---

## 🔌 API Documentation (High-Level)

### AI Service Endpoints

* `POST /ai/ask` – AI study assistant questions
* `POST /ai/summarize` – Notes summarization
* `GET /ai/group-suggest` – Study group suggestions

### Backend Endpoints

* User authentication & profile management
* Study group creation and management
* Notification scheduling

> ⚠️ Detailed API specifications are private due to academic restrictions.

---

## 📚 Academic Context

* Institution: **The ICT University**
* Project Type: **Academic**
* Visibility: **Private**

This project is developed strictly for educational purposes and evaluation.

---

## 📌 License

This project is **private and academic-only**. Redistribution or commercial use is not permitted without explicit authorization.

---

## ✅ Status

🚧 Actively developed and integrated as part of academic coursework.

---

*Studyora — Learn smarter, stay focused, succeed academically.*

class StudyPlanEngine:
    def generate_plan(self, availability, subjects, weak_subjects, decision=None):
        plan = {}

        for day, slots in availability.items():
            plan[day] = []
            for i, slot in enumerate(slots):
                if decision and decision["focus"] == "weak_subjects" and weak_subjects:
                    subject = weak_subjects[i % len(weak_subjects)]
                else:
                    subject = subjects[i % len(subjects)]

                plan[day].append({
                    "subject": subject,
                    "time": slot
                })

        if decision and decision["extra_sessions"] > 0:
            plan["AI_EXTRA"] = [
                {"subject": "Revision", "time": "Auto"}
                for _ in range(decision["extra_sessions"])
            ]

        return plan

#!/bin/bash
set -euo pipefail

echo "🧠 Installing Behavior Controller"

# =========================
# CREATE FILE
# =========================
cat > mempalace/controller.py << 'PYEOF'
import random

class BehaviorController:
    def __init__(self):
        self.mode = "normal"

    def update(self, score: int):
        if score < -5:
            self.mode = "recovery"
        elif score > 5:
            self.mode = "explore"
        else:
            self.mode = "normal"

    def decide(self):
        if self.mode == "recovery":
            return "consolidate"
        elif self.mode == "explore":
            return random.choice(["expand", "experiment"])
        return "idle"
PYEOF

echo "✅ controller.py created"

# =========================
# COMMIT + PUSH
# =========================
git add -A

if git diff --cached --quiet; then
  echo "⚠️ No changes"
else
  git commit -m "feat: add adaptive behavior controller"
  git push origin main
  echo "🚀 pushed"
fi

echo "🧠 DONE"

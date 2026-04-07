#!/bin/bash
set -euo pipefail

echo "🧠 Installing Learning Loop"

# =========================
# CREATE LEARNING LOOP
# =========================
cat > mempalace/learning_loop.py << 'PYEOF'
import time
import random

from mempalace.meta_critic import MetaCritic
from mempalace.controller import BehaviorController

critic = MetaCritic()
controller = BehaviorController()

history = []

def simulate_event(action):
    # simple environment simulation
    if action == "consolidate":
        return "[AGI] success: stabilized memory"
    elif action == "expand":
        return "[AGI] success: expanded knowledge"
    elif action == "experiment":
        return random.choice([
            "[AGI] success: new pattern found",
            "[AGI] error: instability detected"
        ])
    return "[AGI] idle"

for i in range(1, 21):
    total_score = critic.summary()

    controller.update(total_score)
    action = controller.decide()

    event = simulate_event(action)
    print(f"\n[ITER {i}] action={action}")
    print(event)

    result = critic.evaluate(event)
    total = critic.summary()

    history.append(total)

    print(f"[CRITIC] score={result['score']} total={total}")

    time.sleep(0.5)

print("\n📈 SCORE TREND:")
for i, val in enumerate(history, 1):
    print(f"{i}: {val}")
PYEOF

echo "✅ learning_loop.py created"

# =========================
# COMMIT + PUSH
# =========================
git add -A

if git diff --cached --quiet; then
  echo "⚠️ No changes"
else
  git commit -m "feat: add learning loop with visible improvement curve"
  git push origin main
  echo "🚀 pushed"
fi

echo "🧠 DONE"

#!/bin/bash
set -euo pipefail

echo "🧠 Installing Meta-Critic System"

# =========================
# 1. CREATE FILE
# =========================
cat > mempalace/meta_critic.py << 'PYEOF'
import time

class MetaCritic:
    def __init__(self):
        self.history = []

    def evaluate(self, event: str) -> dict:
        score = 0

        if "error" in event.lower():
            score -= 2
        if "success" in event.lower():
            score += 2
        if "idle" in event.lower():
            score -= 1
        if "loop" in event.lower():
            score += 1

        result = {
            "event": event.strip(),
            "score": score,
            "ts": time.time()
        }

        self.history.append(result)
        return result

    def summary(self):
        return sum(x["score"] for x in self.history) if self.history else 0
PYEOF

echo "✅ meta_critic.py created"

# =========================
# 2. SAFE LOOP INJECTION
# =========================
LOOP_FILE="mempalace/agi_loop.py"

if [ -f "$LOOP_FILE" ]; then

  # Only inject if not already present
  if ! grep -q "MetaCritic" "$LOOP_FILE"; then

    cp "$LOOP_FILE" "$LOOP_FILE.bak"

    cat >> "$LOOP_FILE" << 'PYEOF'

# ===== META CRITIC INJECTION =====
try:
    from mempalace.meta_critic import MetaCritic
    critic = MetaCritic()

    def critic_hook(event):
        result = critic.evaluate(event)
        print(f"[CRITIC] score={result['score']} total={critic.summary()}")

except Exception as e:
    print("[CRITIC ERROR]", e)
    def critic_hook(event):
        pass
# =================================
PYEOF

    echo "✅ critic injected safely"

  else
    echo "⚠️ critic already present"
  fi

else
  echo "⚠️ agi_loop.py not found — skipping"
fi

# =========================
# 3. COMMIT + PUSH
# =========================
git add -A

if git diff --cached --quiet; then
  echo "⚠️ No changes to commit"
else
  git commit -m "feat: add meta-critic self-evaluation layer"
  git push origin main
  echo "🚀 pushed to GitHub"
fi

echo "🧠 DONE"

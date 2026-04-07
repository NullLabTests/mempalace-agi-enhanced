
# === LEARNING STATE ===
import random

ACTION_STATS = {
    "idle": {"count": 1, "value": 0.0},
    "consolidate": {"count": 1, "value": 0.0},
}

EPSILON = 0.2  # exploration rate

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

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

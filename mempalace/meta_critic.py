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

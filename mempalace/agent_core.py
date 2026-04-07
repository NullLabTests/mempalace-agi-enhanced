import random

class AgentCore:
    def decide(self, stats: dict):
        if stats.get("low_confidence_ratio", 0) > 0.3:
            return "prune"
        if stats.get("stale_ratio", 0) > 0.4:
            return "consolidate"
        if random.random() < 0.1:
            return "snapshot"
        return "idle"

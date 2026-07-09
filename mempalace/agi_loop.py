import sqlite3
import time
from .knowledge_graph import KnowledgeGraph
from .agent_core import AgentCore


def stats():
    conn = sqlite3.connect("mempalace.db")
    c = conn.cursor()
    c.execute("SELECT COUNT(*) FROM triples")
    total = c.fetchone()[0] or 1
    c.execute("SELECT COUNT(*) FROM triples WHERE confidence < 0.3")
    low = c.fetchone()[0]
    c.execute("SELECT COUNT(*) FROM triples WHERE valid_to IS NOT NULL")
    stale = c.fetchone()[0]
    conn.close()
    return {
        "triple_count": total,
        "low_confidence_ratio": low / total,
        "stale_ratio": stale / total,
    }


def run():
    kg = KnowledgeGraph()
    agent = AgentCore()
    print("🧠 LOOP LIVE")

    while True:
        try:
            s = stats()
            a = agent.decide(s)
            print(f"[AGI] {s} → {a}")

            if a == "prune":
                kg.prune_forgetting()
            elif a == "consolidate":
                kg.continuum_consolidate()
            elif a == "snapshot":
                kg.agi_snapshot("auto")

            time.sleep(5)
        except Exception as e:
            print("ERR:", e)
            time.sleep(2)


if __name__ == "__main__":
    run()

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

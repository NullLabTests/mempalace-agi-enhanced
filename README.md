# 🧠 MemPalace AGI Enhanced

> A minimal self-improving agent that scores its own behavior and adapts over time.

---

## ⚡ What This Is

Most “AI agents” just generate outputs.

This one:
- takes actions
- evaluates itself
- adapts over time

A live feedback loop you can actually watch.

---

## 🔁 Core Loop

Action → Outcome → Self-Critique → Score → Adapt → Repeat

---

## 🧪 Example Output

    [ITER 7] action=consolidate
    [AGI] success: stabilized memory
    [CRITIC] score=2 total=-4

    📈 SCORE TREND:
    1: -1
    2: -2
    ...
    7: -4

👉 The agent discovers beneficial actions.

---

## 🚀 Run It

    python3 -m mempalace.learning_loop

---

## 🧠 Why It Matters

This shows a real feedback signal, not just output generation.

---

## ⚠️ Current Limitation

- Oscillates, not fully learning yet

---

## 🔮 Roadmap

- adaptive policy
- memory-driven decisions
- multi-agent dynamics

---

## 🧠 TL;DR

A tiny system that acts, judges itself, and evolves.

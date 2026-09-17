---
title: 'Reinforcement Learning'
source: 'https://en.wikipedia.org/wiki/Reinforcement_learning'
description: 'An agent learns to act in an environment by maximizing cumulative reward through trial and error.'
tags: ['deep-learning', 'reinforcement-learning', 'reward', 'policy']
---

# Reinforcement Learning

## Overview

Reinforcement learning trains an agent that interacts with an environment step by step. At each step the agent observes a state, takes an action, receives a reward, and transitions to a new state. The goal is to learn a policy that maximizes the total reward over time. There are no labeled examples. The agent discovers what works by trying things and observing consequences. This makes RL fundamentally different from supervised learning, where correct answers are given upfront.

The core tension in RL is exploration versus exploitation. The agent must try new actions to discover better strategies, but it must also use what it already knows to collect reward. Policy-based methods learn a direct mapping from states to actions. Value-based methods estimate how good each state or action is and pick the best. Modern deep RL combines neural networks with these ideas to handle high-dimensional states like images or language. RLHF applies this loop to align language models with human preferences.

### Quick Takeaways

- An agent learns by interacting with an environment and receiving reward signals
- The core tradeoff is exploration of new actions versus exploitation of known good ones
- RLHF uses reinforcement learning to align language models with human judgment

## Definition

- **Agent** is the learner that observes states, chooses actions, and receives rewards.
- **Environment** is everything outside the agent that produces states and rewards in response to actions.
- **Policy** is a function that maps states to actions, either deterministically or as a probability distribution over actions.
- **Value function** estimates the expected cumulative reward from a given state or state-action pair under the current policy.
- **Reward signal** is the scalar feedback the environment gives after each action, telling the agent how good or bad that action was.
- **Exploration vs exploitation** is the tradeoff between trying new actions to discover better strategies and repeating actions known to yield high reward.

## The Analogy

A dog learns tricks without a textbook. The owner says "sit" and the dog tries random movements. When the dog happens to sit, the owner gives a treat. Over many repetitions the dog associates the command with the action because the reward was consistent. The dog does not have an answer key of correct postures. It learns entirely from whether the treat comes or not. Reinforcement learning is the dog, the treat is the reward, and the owner's judgment is the environment.

## When You See It

- Training a game-playing agent like AlphaGo or Atari bots through self-play
- Robotics control where a physical arm learns to grasp objects by trial and error
- RLHF where a language model is fine-tuned to produce responses that human raters prefer
- Recommendation systems that learn which items to show by observing user clicks over time
- Autonomous navigation where a vehicle learns routes through simulated environments
- Resource allocation systems that learn to schedule jobs across servers to minimize latency

## Examples

**Good:** Training a robotic arm to stack blocks using a reward of plus one for each successfully placed block. The sparse but clear reward lets the agent discover stacking strategies through thousands of episodes.

**Bad:** Giving the robotic arm a reward only when all ten blocks are perfectly stacked. The reward is too sparse and the agent almost never stumbles into success, so it cannot learn anything.

**Good:** Using RLHF to align a language model by training a reward model on human preference data and then optimizing the policy against it. The model shifts toward producing responses humans rate as helpful and safe.

**Bad:** Training RLHF without a KL penalty against the base model. The policy collapses to producing a narrow set of high-reward outputs that exploit the reward model rather than genuinely improving quality.

## Important Points

- RL does not need labeled data but it needs a well-designed reward signal
- Sparse rewards make learning extremely hard because the agent gets no signal most of the time
- The discount factor controls how much the agent cares about future reward versus immediate reward
- Deep RL uses neural networks to approximate policies or value functions in high-dimensional spaces
- RLHF bridges RL and language models by using human preferences as the reward source
- Reward hacking occurs when the agent finds unintended shortcuts that maximize reward without achieving the real objective
- Sample efficiency is a major challenge because RL often needs millions of environment interactions to learn
- Model-based RL learns a world model to simulate the environment and plan ahead, reducing real interaction needed

## Summary

- Reinforcement learning trains an agent through interaction with an environment using state, action, and reward.
- Policy methods learn what to do directly and value methods learn what each state is worth.
- Exploration and exploitation must be balanced or the agent either stagnates or wanders forever.
- RLHF connects this paradigm to language model alignment using human preference as reward.
- Reward design is the hardest part because the agent optimizes exactly what you measure, not what you mean.
- _The treat teaches the trick, but only if the dog gets to try sitting first._

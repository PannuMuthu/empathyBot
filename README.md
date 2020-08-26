# README

## Background

This is my work on creating an empathy AI chatbot that can run on various platforms  including Facebook Messenger, Amazon Alexa, SMS, Slack, etc. The goal of this project is to use inverse reinforcement learning techniques in order to develop a chatbot that learns from the empathetic actions of human conversation in order to become an empathy-AI chatbot. The goal is that this project will help bridge the gap between people and machines and increase interconnectivity and friendliness with machine learning and AI techniques. 

This project is sponsored by the UCI UROP and SURP grants. 

## Intuition
In supervised learning, the algorithms are trying to make outputs mimic labels $y$ given in the training data $x$. The labels $y$ are the ”only” right answer to $x$. IN RL, we do not know what the correct action is, we just know after we take an unspecified action, the effect is either rewarding or punishing. Thus we use a reward function to motivate an agent. RL problems in the real world are modeled with Markov Decision Processes.

**Definition**. A Markov Decision Process (MDP) is a 5 tuple denoted $(S, A, \{P_{sa}\}, γ, R)$

where

-   $S$ - set of all possible states
    
-   $A$ - set of all possible actions
    
-   $\{P_{sa}\}$ - set of state transition probabilities, the probability that agent ends up at different state $s′$ given agent starts at state s and takes agent $a$, $P_{sa} : S → \mathbb{R}$ $(\sum_{s′} P_{sa}(s′) = 1)$
    
-   γ - discount factor (γ ∈ [0, 1))
    
-   $R$ - Reward function, $R : S → \mathbb{R}$ (Reward functions can also be functions of states and actions, in which case $R : S × A → \mathbb{R}$)
  
   In this case, we are going to focus on inverse reinforcement learning in a finite MDP. The goal of inverse reinforcement learning is to recover a reward function R given a finite-state MDP without a reward function, but a set of features which are the observable actions from optimal policy π∗. For simplicity and in cases of large state spaces, it is assumed that the reward function is a linear combination of these features or basis functions denoted $φ : S → [0, 1]^n$. These features can be binary corresponding to a particular action a ∈ A being implemented by optimal policy $π^∗$.

In our case, a possible feature set could include whether or not to laugh when a human tells a joke, whether or not to apologize after a person says that they are frustrated, or whether or not to offer advice when someone is in therapy. We can then define a reward function being a linear combination of these features and corresponding weights $w ∈ \mathbb{R}^n$: $$R(s)=w_1φ_1 +w_2φ_2 +···+w_nφ_n =w_T ·φ(s).$$
Our inputs to the IRL problem are a finite state MDP 4 tuple $(S, A, \{P_{sa}\}, \gamma )$ and our feature set $\phi(s)$. Sometimes, the input MDP is a 5 tuple denoted $(S, A, \{P_{sa}\}, \gamma, D)$ with $D$ being the distribution of the initial state($s_0 = s$). Also, sometimes we assume the optimal weight vector L1 norm $||\mathbf{w}^*||_1 \leq 1$ to ensure that the reward function is bounded by 1. 

Thus, a preliminary goal of IRL is to identify the weight vector $\mathbf{w}$ in order to find the reward function $R$ given a set of demonstrations $\phi(s)$ (binary transformations of actions taken by optimal policy $\pi^*$). For IRL we define the value function  $V^\pi(s)$ of policy $\pi$ at state $s$ with the initial state $s_0 \sim D$ as follows:
$\begin{align*}
    V^\pi(s) &= \mathbb{E}_{s_0 \sim D}\bigg[ \sum_{t=0}^{\infty} \gamma^t R(s_t) \big| s_0 = s, \pi \bigg] \\
    &= \mathbb{E}_{s_0 \sim D}\bigg[ \sum_{t=0}^{\infty} \gamma^t \mathbf{w}^T \phi(s_t) \big| s_0 = s, \pi \bigg] \\
    &= \mathbb{E}_{s_0 \sim D}\bigg[ \sum_{t=0}^{\infty} \gamma^t \mathbf{w}^T \cdot \phi(s_t) \big| s_0 = s, \pi \bigg] \\
     V^{\pi}(s) &= \mathbf{w}^T \mathbb{E}_{s_0 \sim D}\bigg[ \sum_{t=0}^{\infty} \gamma^t  \cdot \phi(s_t) \big| s_0 = s, \pi \bigg]
\end{align*}$


Thus we can define a function $\mu(\pi): \prod \mapsto \mathbb{R}^n$, where $\prod$ is the set of all policies $\pi$, denoted the \textbf{ feature expectation} corresponding to the expected discounted weighted frequency of the state features under policy $\pi$:
$$\mu(\pi) = \mathbb{E}_{s_0 \sim D}\bigg[ \sum_{t=0}^{\infty} \gamma^t  \cdot \phi(s_t) \big| s_0 = s, \pi \bigg].$$

We can now refine our definition of the value function in the case of IRL to $$V^{\pi}(s) = \mathbf{w}^T \mu(\pi).$$

Note that we have already shown that $$\mathbb{E}\bigg[ \sum_{t=0}^{\infty} \gamma^t R^*(s_t) \big| s_0 = s, \pi^* \bigg] = V^* \geq V^{\pi} = \mathbb{E} \bigg[\sum_{t=0}^{\infty} \gamma^t R^*(s_t) \big| s_0 = s, \pi \bigg].$$
Thus, if the set of features $\phi(s)$ are from the optimal policy, then to identify $\mathbf{w}$ it is sufficient to find $w^*$ such that 
$$w^*^T \mu(\pi^*) \geq w^*^T  \mu(\pi), \forall \pi \neq \pi^*$$



The ultimate goal of inverse reinforcement learning is to use the estimated $w^*$ and the expert's feature expectations $\mu(\pi^*)$ to calculate a policy $\tilde^{\pi}$. There are a variety of algorithms to find $\tilde^{\pi}$ including MaxEnt, RelEnt, generative adversarial networks, and guided cost learning.



# <a href='https://hellostealth.org'><img src='http://assets.blackops.nyc/stealth/logo.svg' height='120' alt='Stealth Logo' aria-label='hellostealth.org' /></a>

To boot this bot locally, we recommend the following:

1. `bundle`
2. Start your local Redis server
3. `stealth s`

For more information, please check out the [Stealth documentation](https://hellostealth.org/docs).

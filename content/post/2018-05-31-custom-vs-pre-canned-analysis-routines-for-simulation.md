---
title: Custom vs. pre-canned analysis routines for simulation
author: John Johnson
date: '2018-05-31'
slug: custom-vs-pre-canned-analysis-routines-for-simulation
categories:
  - General
tags:
  - reflection
  - statistics
---

I'm currently running some simulations that involve running logrank tests over and over. One analysis requires 1000 runs of the logrank test. One simulation scenario requires 1000 analyses. Thus, one scenario requires the running of a million logrank tests! In addition, it requires the rerunning of the Pocock-Simon minimization algorithm for treatment assignment.

At first, I coded these in R using the pre-canned logrank test from the `survival` package. However, it took 20 minutes to run one rerandomization test, not to mention that 1000 of these tests would take about a month.

I did about as much optimization as I could and couldn't make enough headway to make this simulation feasible. So I switched to the Julia language. In doing so, I had to recode my own logrank test. (Julia is great for scientific computing, but not so great for data analysis.) I was annoyed at first, but a logrank test is not hard to code up, especially because I know what the inputs look like (I simulate them!). This got me reflecting on the unsuitability of pre-done statistical routines for simulation. Most of the time in these routines is spent checking input, creating model matrices from data frames, or other overhead. This overhead is mostly unnecessary when you are running simulations because you control the input into these routines as well. You can save a lot of time if you code your own routine.

Of course, this comes back to the question of whether you spend time and cognitive bandwidth writing code or spend time running code. In my particular case, because running the code required so much time, I spent a lot of time writing and verifying new code (had to check my stripped-down logrank routine against the pre-written routine for a reasonable range of simulation inputs) and only a few minutes at a time per analysis scenario. Now my full range of scenarios requires about 4 hours to run rather than, say, 20 months.
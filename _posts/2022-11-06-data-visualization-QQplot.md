---
layout: post
title: "Understanding Q-Q Plots"
subtitle: "Story-telling with data 6/N"
author: "Ryo"
header-img: "img/bg-statistics.png"
header-mask: 0.4
catelog: true
mathjax: true
revise_date: 2023-01-12
tags:

- Data visualization
- Python
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4">&nbsp;&nbsp;Table of Contents</p>
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [What is Q-Q Plots?](#what-is-q-q-plots)
- [The gist of Q-Q Plots](#the-gist-of-q-q-plots)
  - [Make Q-Q Plots with Python](#make-q-q-plots-with-python)
  - [Filliben's estimate 1975](#fillibens-estimate-1975)
- [Detail: Q-Q Plots with Python](#detail-q-q-plots-with-python)
- [Appendix: Percentile vs quantile vs quartile](#appendix-percentile-vs-quantile-vs-quartile)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

</div>

## What is Q-Q Plots?

The Q-Q plot, or quantile-quantile plot, is a graphical tool to help us assess if a set of data plausibly came from some theoretical distribution such as a Normal or exponential. Please note that it’s just a visual check, not an air-tight proof, so it is somewhat subjective. But it allows us to see at-a-glance if our assumption is plausible, and if not, how the assumption is violated and what data points contribute to the violation.

To give a concrete example, assume the actual data values have a mean of 10 and a standard deviation of 3. Then, assuming a normal distribution, we would expect a data point ranked at the 50th percentile to lie at position 10 (the mean), a data point at the 84th percentile to lie at position 13 (one standard deviation above from the mean).


## The gist of Q-Q Plots

For $n$ i.i.d observations $\{y_i\}$, let us define the order statistics from $\{y_i\}$ such that

$$
y_{\{1\}} \leq y_{\{2\}} \leq \cdots \leq y_{\{n\}} 
$$

Let $q_i$ be the $i/(n+1)$ quantile of some theoretical distribution, for $i = 1, 2, \cdots, n$.

When $\{y_i\}$ come from the same theoretical distirbution, the pair of the order statistics and $q_i$, i.e., 

$$
(q_1, y_{\{1\}}), (q_2, y_{\{2\}}), \cdots, (q_n, y_{\{n\}})
$$

should be approximately on the straight line, more closely so when $n$ is large.


### Make Q-Q Plots with Python

```python
import matplotlib.pyplot as plt
import numpy as np
from scipy.stats import norm

N = 1000
mu = 0
sd = 1
np.random.seed(42)

## GDP
x = np.random.normal(mu, sd, N)

x_sorted = sorted(x)
x_theoretical = norm.ppf((np.arange(1, N+1))/(N+1))
abline_pair = [min(x_theoretical), max(x_theoretical)]

plt.scatter(x_theoretical, x_sorted)
plt.plot(abline_pair ,abline_pair , color='r')
```

> Scipy: probplot

- Note that the red line is not "45 degree" line, but just the fitting line

```python
import numpy as np
from scipy.stats import norm
from scipy.stats import probplot

N = 1000
mu = 0
sd = 1
np.random.seed(42)

## GDP
x = np.random.normal(mu, sd, N)

## scipy plot
fig, ax = plt.subplots()
res = probplot(x, dist=norm, plot=ax)
```

### Filliben's estimate 1975

When you look closely at `scipy.stats.probplot`, you will notice that the module is using Filliben's Estimate.
The docstring says the followings:

```
The formula used for the theoretical quantiles (horizontal axis of the
probability plot) is Filliben's estimate::

        quantiles = dist.ppf(val), for

                0.5**(1/n),                  for i = n
          val = (i - 0.3175) / (n + 0.365),  for i = 2, ..., n-1
                1 - 0.5**(1/n),              for i = 1

where ``i`` indicates the i-th ordered value and ``n`` is the total number
of values.
```

The above magic numbers, `0.3175, 0.365, 0.5**(1/n)`, are based on Filliben's simulation for calculating the median of the order statistic.

The simple intuition is that when you want to estimate the parameters of the uniform distibution, you have to correct the min and max of the sample for getting the unbiased estimators (even though the simple mim and max estimators are consistent ones).

## Detail: Q-Q Plots with Python

```python
import matplotlib.pyplot as plt
import numpy as np


def _add_axis_labels_title(plot, xlabel, ylabel, title):
    """Helper function to add axes labels and a title to stats plots."""
    try:
        if hasattr(plot, 'set_title'):
            # Matplotlib Axes instance or something that looks like it
            plot.set_title(title)
            plot.set_xlabel(xlabel)
            plot.set_ylabel(ylabel)
        else:
            # matplotlib.pyplot module
            plot.title(title)
            plot.xlabel(xlabel)
            plot.ylabel(ylabel)
    except Exception:
        # Not an MPL object or something that looks (enough) like it.
        # Don't crash on adding labels or title
        pass

def _add_x_and_y_lim(plot, x_range, y_range):
    """Helper function to add axes labels and a title to stats plots."""
    try:
        if hasattr(plot, 'set_title'):
            # Matplotlib Axes instance or something that looks like it
            plot.set_xlim(x_range)
            plot.set_ylim(y_range)
        else:
            # matplotlib.pyplot module
            plot.xlim(x_range)
            plot.ylim(y_range)
    except Exception:
        # Not an MPL object or something that looks (enough) like it.
        # Don't crash on adding labels or title
        pass

def qqplot(x, y=[], sparams=(), dist='norm', filliben=True, percentile=False, plot=None):
    x = np.asarray(x)
    y = np.asarray(y)

    x_size = x.size

    if x_size < 20:
        raise ValueError("x need at least 20 data-points.")
    
    if filliben:
        v = np.empty(x_size, dtype=np.float64)
        v[-1] = 0.5**(1.0 / x_size)
        v[0] = 1 - v[-1]
        i = np.arange(2, x_size)
        v[1:-1] = (i - 0.3175) / (x_size + 0.365)
    else:
        v = (np.arange(1, x_size+1))/(x_size+1)

    if y.size == 0:
        try:
            from scipy.stats import distributions as scipy_dist
            dist = getattr(scipy_dist, dist)
            
            if sparams is None:
                sparams = ()
            if np.isscalar(sparams):
                sparams = (sparams,)
            if not isinstance(sparams, tuple):
                sparams = tuple(sparams)
            
            ## get theoretical values
            if percentile:
                y_cdf = dist.cdf
                osm = v
            else:
                osm = dist.ppf(v, *sparams)

        except AttributeError as e:
            raise ValueError("%s is not a valid distribution name" % dist) from e
    else:
        if y.size < 20:
           raise ValueError("y need at least 20 data-points.")
        if percentile:
            from statsmodels.distributions.empirical_distribution import ECDF
            
            y_cdf = ECDF(y)
            osm = v

        else:
            osm = np.quantile(y, v)
    
    if percentile:
        osr = y_cdf(sorted(x))
    else:
        osr = sorted(x)

    if plot is not None:
        plot.plot(osm, osr, 'bo')
    else:
        plot = plt
        plot.plot(osm, osr, 'bo')
    
    if percentile:
        _add_axis_labels_title(plot, xlabel='Theoretical percentile',
                               ylabel='Ordered Values',
                               title='Percentile-Percentile Plot')
        _add_x_and_y_lim(plot, x_range=[-0.05,1.05], y_range=[-0.05,1.05])
        plot.plot([0, 1], [0, 1], 'k--')

    else:
        _add_axis_labels_title(plot, xlabel='Theoretical quantiles values',
                               ylabel='Ordered Values',
                               title='Quantile-Quantile Plot')
        _range = min(osm), max(osm)
        plot.plot(_range, _range, 'k--')

    #return osm, osr
```

## Appendix: Percentile vs quantile vs quartile

---|---|---|---
min|0 quartile | 0 quantile | 0 percentile
|1 quartile | 0.25 quantile | 25 percentile
median|2 quartile | .5 quantile | 50 percentile
|3 quartile | .75 quantile | 75 percentile
max|4 quartile | 1 quantile | 100 percentile



## References

> scipy

- [scipy.stats.probplot source code](https://github.com/scipy/scipy/blob/v1.10.0/scipy/stats/_morestats.py#L485-L645)

> Q-Q Plot

- [Research Data Services + Sciences, University of Virginia Library > Understanding Q-Q Plots](https://data.library.virginia.edu/understanding-q-q-plots/)
- [Filliben's estimate 1975](https://www1.cmc.edu/pages/faculty/MONeill/Math152/Handouts/filliben.pdf)
- [The Probability Plot Correlation Coefficient Test for the Normal,Lognormal, and Gumbel Distributional Hypothese](https://sites.tufts.edu/richardvogel/files/2019/04/probability1986.pdf)
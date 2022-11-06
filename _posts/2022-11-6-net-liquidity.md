---
layout: post
title: Net Liquidity
---

By now, most interested investors should be aware of what the Fed has been doing and its impact on assets. 

Recently, I came across two interesting articles/threads which argue that it isn't really the size of the Fed's balance sheet that matters, but rather a subset of it called "net liquidity". [(1)](https://twitter.com/maxjanderson/status/1546472693234470912) [(2)](https://thelastbearstanding.substack.com/p/draining-the-repo)

It seems interesting enough to validate empirically. So, here's a simple dashboard together using Fed data to see how "net liquidity" tracks against the S&P 500. Certainly, looking at since COVID escalated globally and Fed did QE in response, net liquidity seems to track quite against the S&P 500, at least visually. I have also added lagged % change in net liquidity and twice lagged as one of the sources suggest that net liquidity is correlated with S&P 500 2 weeks later (mostly 2 data points later). There are some gaps in data, I think partly because I applied strict date-matching when joining the pieces of data together which affected some data points (not too sure as I put this together quickly and did not check for fuzzy date-matching).

I've started learning Python but not proficient enough yet to put a dashboard together so this was done in R Shiny.

<iframe height="1000" width="100%" frameborder="no" src="http://clementweegk.shinyapps.io/net_liquidity"> </iframe>







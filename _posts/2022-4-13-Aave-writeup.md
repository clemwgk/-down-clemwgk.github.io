---
layout: post
title: Aave write-up 
---

I recently applied for [Messari Hub](https://messari.io/hub) but haven't heard back yet. The research task for the application is to answer a few questions about [Aave](https://aave.com/). I've decided to pen down my responses here too, for the record, irrespective of outcome.

### What problem is the protocol solving? (3-4 sentences) ###

Being able to borrow or lend is a basic building block of finance. In traditional finance, banks act as financial intermediaries to aggregate and manage borrowing and lending activity, and are incentivised to do so as they can profit from the difference between their cost of liabilities to lenders and what they earn from borrowers. However, in decentralised finance (DeFi), such centralised entities do not exist by definition, so how does borrowing and lending take place in this permissionless, decentralised environment? Aave solves this, allowing anyone to participate in borrowing or lending without requiring a centralised entity.

### Describe the protocol, how it works (250 words) ###

Aave is a system of lending pools, first deployed on Ethereum in Jan 2020, and now live across seven blockchains, including popular alternative L1 blockchain Avalanche and Ethereum L2 Polygon. Lenders deposit funds into a liquidity pool and receive interest on their deposits. Borrowers obtain loans from these liquidity pools instead of being matched directly (peer-to-peer) with a lender. 

These loans are generally overcollateralised; borrowers deposit collateral of greater value than the amount borrowed, and the collateral can be of a different asset type as the borrowed asset. Borrowers pay varying interest on the loan depending on the utilisation of the liquidity pool that the loan is drawn from. If cryptocurrency prices fluctuate such that the value of a borrower’s collateral drops below a certain threshold (reflected as the “health factor” falling below 1 in Aave), other parties known as liquidators are incentivised to repay up to 50% of the borrower’s debt through allowing the liquidators to purchase part of the borrower’s collateral at a discount. These liquidations keep the protocol solvent. 

Aside from overcollateralised loans, tech-savvy borrowers can also engage in “flash loans”, which do not require collateral but must be repaid within the same block transaction. 

Since its initial launch, Aave has had two major upgrades, Aave V2 and V3, with features to improve capital efficiency and risk mitigation. Some improvements include the ability to trade collateral (e.g. for a stablecoin, to avoid liquidations), and cross-chain borrowing (e.g. deposit collateral on Ethereum mainnet, borrow on Polygon).

### Explain the token, tokenomics, how it accrues value (250 words) ###

Aave’s token, AAVE, is an ERC-20 token on Ethereum with a total supply of 16mil and a circulating supply of approx. 13.7mil. It is a governance token; AAVE holders collectively govern Aave, and can propose changes and vote on proposals regarding Aave.

Currently, staking seems to be the only avenue for AAVE holders to directly gain value from the token. Holders can stake AAVE to earn a yield (currently about 7%, paid in AAVE). In exchange, they take on additional risk to secure the protocol – part of the staked AAVE will be used to mitigate any deficit faced by liquidity providers on Aave. But this still begs the question of how AAVE accrues value outside of simply generating more AAVE for the holder.

As a governance token, AAVE has the potential to generate value for holders in future. Through the governance process, AAVE holders can propose and vote to reward themselves more directly in future. If Aave succeeds in the long-term, AAVE holders could, for example, vote to use the Aave treasury to more directly reward token holders. AAVE holders collectively control the Aave treasury, which grows from transaction fees, staking, and liquidations.

At the time of writing, Aave was recently announced as one of nine selected partners to help Brazil’s central bank develop a digital currency. Continued involvement in such projects and improvements to Aave could draw more users to Aave relative to its competitors, contributing to Aave’s long-term success and bringing value to token holders.

_Additional comment: I think it is quite well-observed that DeFi governance tokens generally haven't done very well. Is governance being undervalued or is it really worthless? This actually reminds me of some game theoretic situations._

_For individuals who are not whales, what good is a governance token? If I am active in the governance process, my share is so small that it doesn't change the outcome. If I am not active, then I still get to free-ride on governance decisions made by others. So individually, if you buy these premises, I suppose you would arrive at the conclusion that governance is not worth much for small investors. Question is, how true is it that small investors have little impact in the governance process?_

### What market does the protocol compete in? ###

To define the relevant market, we should consider where Aave users would switch to if they were to switch away from Aave. Based on this, one way to define the market is to say that Aave competes with other major lending and borrowing protocols on all 7 blockchains that Aave is live on (as of the recent Aave V3 announcement). In particular, Aave primarily competes with similar protocols on Ethereum, such as Compound, as Aave has the most total value locked (TVL) on Ethereum, and Ethereum has the largest amount of DeFi TVL across different blockchains.

However, this view is probably too narrow, and I believe that Aave also competes with major lending and borrowing protocols on other blockchains that Aave is not live on. This is because more blockchains have continued to gain prominence and credibility, and more avenues for cross-chain bridging have emerged (such as Stargate Finance), making it easier and less risky for users to move funds across blockchains. An example of such a protocol would be the Anchor protocol on Terra, which recently overtook Aave in TVL terms. (Anchor protocol recently went live on Avalanche, which Aave is also live on, but most of Anchor’s TVL is still on Terra.)

### Bonus question: If you were to prepare a financial statement for this protocol, what would be the top 5 metrics to include? ###

In a traditional financial statement, the key metrics are assets, liabilities, revenue, cost, and cash flow. I would apply the same concepts to Aave, except replacing cash flow with a measure of protocol risk, which should reflect the risk of an existential crisis for Aave. 

Accordingly, the top 5 metrics in my view are:
1) Assets: Outstanding amount loaned out to borrowers (borrowers owe Aave). This is not Aave’s total assets as Aave also has its treasury, but this is the asset base on which Aave directly generates revenue.
2) Liabilities: Total value locked (TVL) on Aave (owed to lenders)
3) Revenue: Fees paid to Aave by borrowers
4) Cost: Fees paid out from Aave to lenders
5) Protocol risk: Amount of insolvent debt on Aave (as a % of TVL), net of collateral value deposited by the insolvent accounts. Protocol risk for Aave arises when there is a significant amount of bad debt not dealt with by liquidations or top-up events. Too much bad debt could result in lenders not being able to withdraw their deposits when they want to, sparking mass liquidity withdrawals (equivalent of a bank run) and eroding trust in the protocol. It is an existential threat for Aave as Aave cannot function without lenders.

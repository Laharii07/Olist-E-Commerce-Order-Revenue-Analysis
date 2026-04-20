/*
This query is the Supply-Side Pareto Analysis. Just as we analyzed customer concentration, this query measures Seller Concentration. It answers the vital question: "Is our marketplace healthy and diverse, or are we overly dependent on a few 'Mega-Sellers'?"

Why Analysts Use This Query:
Platform Fragility Assessment: If your top 20% of sellers contribute 90% of the revenue, your business is highly vulnerable. If one or two of those top sellers leave for a competitor (like Amazon or eBay), your platform's revenue could collapse overnight.

Tail Management Strategy: If the top 20% do almost everything, analysts investigate the "Long Tail" (the bottom 80%). This helps decide whether to prune underperforming sellers or invest in better onboarding tools to help small sellers grow.

Negotiation Leverage: Knowing that a small group provides the majority of your GMV (Gross Merchandise Volume) gives those sellers significant power. Analysts use this to balance commission rates—offering volume discounts to the top 20% while ensuring the platform remains profitable.

Monopoly/Anti-Trust Monitoring: For massive global platforms, monitoring concentration ensures that no single entity is stifling competition within the marketplace, which is crucial for legal compliance.

Identifying Marketplace "Stars": This list identifies the "Power Sellers" who should be prioritized for beta-testing new features, such as advanced advertising tools or priority logistics programs.

Technical Insight: The NTILE(5) Logic
By using NTILE(5), you have perfectly sliced the seller population into "Quintiles" (20% chunks).

The Aggregation: Your SUM(CASE WHEN...) is a clean way to perform a "Partial Sum" against the "Total Sum" in a single step.

Zero-Revenue Sellers: Note that if you have sellers who registered but never sold anything, they might not be in the order_items table. Analysts often check the sellers table separately to see the percentage of "Inactive" versus "Active" sellers.
*/

-- Question 48 Find revenue contribution by top 20% sellers.--
WITH seller_revenue AS (
    SELECT 
        seller_id,
        SUM(price + freight_value) AS revenue
    FROM order_items
    GROUP BY seller_id
),
ranked_sellers AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY revenue DESC) AS percentile_group
    FROM seller_revenue
)

SELECT 
    SUM(CASE WHEN percentile_group = 1 THEN revenue ELSE 0 END) * 100.0 
        / SUM(revenue) AS top_20_percent_revenue
FROM ranked_sellers;

# Replicate interesting visualizations and learn

- Yale Program on Climate Change Communication @YaleClimateComm conduct research on public climate change knowledge, attitudes, policy support& behavior
- The visualization to replicate was the one below
![Original](https://raw.githubusercontent.com/rahulvenugopal/ReplicateViz/main/Climate%20change%20communication/images/Global%20warming.png)
- Replicated version
![](https://raw.githubusercontent.com/rahulvenugopal/ReplicateViz/main/Climate%20change%20communication/images/Global%20warming%20replication.png)

- Read more from the [source](https://climatecommunication.yale.edu/publications/climate-change-in-the-american-mind-september-2021/)
- Takeaways
1. 2D plots are not intuitive for comparisons like this
2. Barplots are just fine
3. Spotted that the areas were wrongly scaled! Have asked twitter world and @azandisarietta was generous in helping out
4. I missed mapping the size variable inside aes() and was trying to assign size parameter inside geom_point
5. Came to know about a python program to detect circles in an image (added to repo)
---


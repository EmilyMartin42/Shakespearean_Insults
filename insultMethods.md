# Methods

## What is an insult?

General definition: Any form of deragotory, abusive, or disrespectful remark/action

### Remarks
1. Name Calling
    1. Explanation: The act of calling someone something they are not with the intent to harm their personal image.
    1. Example: "Thou are a pig"
    1. `insType="nameCall"`
1. Personal attack
    1. Explanation: The act of comparing an attribute of someones character or skill to that of something far worse or lacking.
    1. Example: "Thine sword skills are like those of a child"
    1. Example: "You are fat (dumb, small, etc.)"
    1. `insType="pAttack"`
1. Insults on sexuality/gender
    1. Explanation: An attack on someones gender or sexuality and comparing them to their opposite
    1. Example: "Thou throw like a girl"
    1. `insType="sexGen"`
1. Backhanded compliment
    1. Explanation: Intending to compliment someone, but doing so in such a way as to show that the held belief of them was disrespectful/negative.
    1. Exaple: "Thine dress blesses my eyes with a thinner sight"
    1. `insType="backComp"`
1. Slander (Insulting someone behind their back)
    1. Explanation: Any form of disparaging, belittling, or diminishing speak about someone to another other than those being insulted.
    1. Example: "Hamlet has been having affairs with the court cur"
    1. `insType="slander"`

### Actions - No longer in the scope of the project
1. Denying satisfaction/ breaking tradition
    1. Explanation: Disrespecting the honor of someone being insulted by way of denying something that they want or require. This must be something they require to appease others or the cultural system, not just themselves.
    1. Example: "Raise your sword, demon!" *Opponent exit stage right*
    1. `insType="denySat"`
1. Shunning / ignoring
    1. Explanation: Ignoring another character's speech, actions, or requests.
    1. Example: "Hamlet, I implore you to give my ears the grace of your voice" *Hamlet says nothing*
    1. `insType="shun"`
1. Physical embarrasment (especially in front of group)
    1. Explanation: To publicly humiliate someone in front of others through physical embarrasment, such as slapping or pant pulling.
    1. Example: "What you egg?" *Slaps him*
    1. `insType="physEmb"`

## How to markup

1. Empty tag before the first word in the insult as the start. Then, after the insult, tag after the most relevant word or article of punctuation.
    ```
    `<insultStart insType=""/>` 
    Insert line(s) here 
    `<insultEnd/>`
    ```    
1. In the event that there are multiple categories under which an insult may fall, the attribute value should contain both types separated by a space. The order of these should be the same as the list above and not by what is deemed important by the reader.
   Example: `<insultStart insType="nameCall sexGen">`

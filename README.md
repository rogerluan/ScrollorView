<H1 align ="center">Scrollor</H1>

##Description
I wanted to mess around with a scroll view, its delegate and some other fun color mixing techniques, so I thought about this project.

It is a paged scroll view that changes its background color as you slide, and animate the color change, displaying the intermediate color during the transition. What it actually does is use the average color components (RGB) between both pages.

##Learned Skills
I used the project mainly have fun messing with an animated scroll view and deal with colorful elements. But in the meanwhile, I learn some things...

So far:

- Use scroll view didScroll delegate to change an UI behavior
- Calculating average color components

##Road Map

- Facilitate the customization and implantation of Scrollor in 3rd party projects
- Create a Cocoapod
- Change the way the Scrollor holds the content inside it

##Known Bugs

- None - If you find any, please report!

##Credits

Got this idea from Slack's presentation scroll view. It probably uses [Presentation](https://github.com/hyperoslo/Presentation) or some other framework to create their presentation, but anyways they inspired me to build this.

##Contact

Twitter: [@Rogerluan\_](https://twitter.com/rogerluan_)

##License

MIT License.
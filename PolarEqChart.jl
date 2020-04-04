using Plots
import Base: write, push!, show
gr()
Plots.GRBackend()

## Gif to Video Conversion
function write2(f::String, file::String, fps)
    # TODO: more ffmpeg options
    dir = file
    ffmpeg_exe(`-y -r $fps -f gif -i $dir $f -loglevel error`)
    #frames.rendered = f
end

##
#p = scatter(r .*cos(1),r .*sin(1), leg=false)
p = plot(zeros(9)',zeros(9)', leg=false)
p1 = plot(zeros(9)',zeros(9)', leg=false)
p2 = plot(zeros(5)',zeros(5)', leg=false)
p3 = plot(zeros(5)',zeros(5)', leg=false)
p22 = scatter([cos, sin], zeros(0), leg=false,proj=:polar)
p23 = scatter([cos, sin], zeros(0), leg=false)
#anim = Animation()
anim= @animate for x = range(0, stop=3π, length=200)
    #1 Changes of a
    b=0.0
    k=5.0
    a=2:10
    r = 2.0 .*a .*sin(k .*x) .+ b
    push!(p,r .*cos(x),r .*sin(x))
    #2 Changes of k
    b1=0.0
    k1=-4.0:4.0
    a1=2.0
    r1 = 2.0 .*a1 .*sin.(k1 .*x) .+ b1
    push!(p1,r1 .*cos(x),r1 .*sin(x))


    #3 Changes of b
    b2=-2.0:2.0
    k2=1.0
    a2=2.0
    r2 = 2.0 .*a2 .*sin.(k2 .*x) .+ b2
    push!(p2,r2 .*cos(x),r2 .*sin(x))

    #4 Changes of k and b
    b2=-2.0:2.0
    k2=1.0 :5.0
    a2=2.0
    r2 = 2.0 .*a2 .*sin.(k2 .*x) .+ b2
    push!(p3,r2 .*cos(x),r2 .*sin(x))




    push!(p22,Float64[cos(x)],Float64[sin(x)])
    push!(p23,Float64[cos(x)],Float64[sin(x)])
    plot(p,p1,p2,p3,p22,p23,title=["2asin(k*theta)+b=>a change" "k Change" "b Change " "k and b Change" "Circle Polar" "Circle"])
    #frame(anim)
#    display(p)
end



fps1=15
filename= "anim_fps18.gif"
gif(anim,filename, fps =fps1)

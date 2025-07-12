using Godot;
using System;

public abstract partial class State : Node
{
    public abstract bool Start();

    public abstract bool Stop();

    
}

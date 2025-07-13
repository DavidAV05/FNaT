using Godot;
using System;

public abstract partial class State : Node
{
    [Signal]
    public delegate void TransitionEventHandler(State source, string newState);

    public abstract bool Start();

    public abstract bool Stop();

    public abstract void Update(double delta);

    public abstract void PhysicsUpdate(double delta);
}

using Godot;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Xml.XPath;

public partial class StateMachine : Node
{
    // Export vars
    [Export]
    private State InitialState = null;

    public State CurrentState { get; set; } = null;

    private readonly Dictionary<string, State> states = [];

    /// <summary>
    /// Runs at start, adds all children as states, activates starting state.
    /// </summary>
    public override void _Ready()
    {
        foreach (var child in this.GetChildren(false))
        {
            if (child is State state)
            {
                string name = state.Name.ToString().ToLower();
                states.Add(name, (State)child);
                state.Transition += onStateTransition;
            }
        }

        // Start first state
        Debug.Assert(InitialState != null);
        InitialState.Start();
        CurrentState = InitialState;
    }

    public override void _Process(double delta)
    {
        CurrentState?.Update(delta);
    }

    public override void _PhysicsProcess(double delta)
    {
        CurrentState?.PhysicsUpdate(delta);
    }


    /// <summary>
    /// Set machine's state to given states name.
    /// </summary>
    /// <param name="source"> Source of state calling this function. </param>
    /// <param name="newStateName"> String of the state to set machine to.</param>
    public void onStateTransition(State source, string newStateName)
    {
        // Check if calling state truly is current state
        if (source != CurrentState)
        {
            GD.Print(
                "{0}: State {1} was not the current state", this.Name,
                newStateName
                );
            return;
        }

        // To lower to avoid confusion
        newStateName = newStateName.ToLower();

        // Check if new state isn't current state already
        if (newStateName == CurrentState.Name)
        {
            GD.Print(
                "{0}: State {1} was already current state", this.Name,
                newStateName
                );
            return;
        }

        // Check if requested state is part of machine
        if (!states.ContainsKey(newStateName))
        {
            GD.Print(
                "{0}: State {1} was not found within states list", this.Name,
                newStateName
                );
            return;
        }

        // Initialise new state to null
        State newState = states[newStateName];


        // Stop old state
        bool result = CurrentState.Stop();

        if (!result)
        {
            GD.Print(
                "{0}: Error while stopping state: {1}",
                this.Name, newStateName
                );
            throw new Exception("Error stopping current state");
        }

        // Rename current state
        this.CurrentState = newState;

        // Start new state
        newState.Start();

        return;
    }
}
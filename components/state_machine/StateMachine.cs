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
    private State startState = null;

    private State currentState = null;

    private readonly Dictionary<string, State> states = [];

    /// <summary>
    /// Runs at start, adds all children as states, activates starting state.
    /// </summary>
    public override void _Ready()
    {
        foreach (var child in this.GetChildren(false))
        {
            if (child is State)
            {
                states.Add((string)child.Name, (State)child);
            }
        }

        // Start first state
        Debug.Assert(startState != null);
        startState.Start();


    }

    public override void _Process(double delta)
    {
        this.GetChildren(false);
    }

    /// <summary>
    /// Set machine's state to given states name.
    /// </summary>
    /// <param name="stateName"> String of the state to set machine to.</param>
    public void SetState(string stateName)
    {
        // Initialise new state to null
        State newState;

        // Try to get new given state
        try
        {
            newState = states[stateName];
        }
        // If state is not part of states list
        catch (Exception)
        {
            GD.Print(
                "{0}: State {1} was not found within states list", this.Name,
                stateName
                );
            return;
        }

        // Stop old state
        bool result = GetState().Stop();

        if (!result)
        {
            GD.Print("{0}: Error while stopping state: {1}", this.Name,
                stateName);
            return;
        }

        // Rename current state
        this.currentState = newState;

        // Start new state
        newState.Start();

        return;
    }


    public State GetState()
    {
        return currentState;
    }
}
actor {
    stable var currentValue: Nat = 0;

    public func increment(): async () {
        currentValue += 3;
    };

    public query func getValue(): async Nat {
        return currentValue;
    };
};

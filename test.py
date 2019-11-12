import os

def log_permanent(model_parameters):
    """custom csv file writer"""
    if not os.path.exists("./experiment_data.csv"):
        with open("experiment_data.csv", "w") as f:
            # make sure the order is right
            f.write("rnn_size, num_layers, learning_rate, window_size, batch_size, num_epochs, dropout, grad_clip\n")
        with open("experiment_data.csv", "a") as f:
            experiment = ""
            for param in model_parameters:
                if len(experiment) == 0:
                    experiment = param
                else:
                    experiment = f"{experiment}, {param}\n"
            f.write(experiment)

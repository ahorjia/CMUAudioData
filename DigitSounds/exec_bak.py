
import run
mnist = run.read_data_sets("/Users/ali.ghorbani/CMUAudioData/DigitSounds/tmp", one_hot=True)

for i in range(2):
    print i
    batch_xs, batch_ys = mnist.train.next_batch(20)

#test_data = mnist.test.images[:test_len].reshape((-1, n_steps, n_input))
#test_label = mnist.test.labels[:test_len]